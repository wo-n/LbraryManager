# coding: utf-8

class BooksController < ApplicationController

  def index
   @books = Book.order("id")
  end

  def new
  end

  def create
  end

  def show
    @libraries = Library.order("id")
      Amazon::Ecs.debug = true
    @book = Amazon::Ecs.item_search(params[:id],:search_index => 'Books',:response_group => 'Medium')
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
    @libraries = Library.order("id")	#図書館情報
    @keyword = params[:keyword]		#キーワード
    @genre_code = params[:genre_code]	#ジャンル
    @lib_id = params[:lib_id]		#所蔵館
    if @keyword.present?
      Amazon::Ecs.debug = true
      @res = Amazon::Ecs.item_search(params[:keyword],:search_index => 'Books',:BrowseNode => @genre_code, :response_group => 'Medium')
      @result = []				#検索結果の配列
      @res.items.each do |i|
        @data = (isbn10_to_13(i.get('ItemAttributes/ISBN'))).to_i
        if @data > 10000000000			#電子書籍化どうか
          if @lib_id == ""			#図書館指定なし
            @book = Book.find_by_isbn(@data)
          else
            @book = Book.find_by_isbn_and_library_id(@data, @lib_id)
          end
          
          if @book != nil			#図書DBに存在するかどうか
           @result << [i.get('SmallImage/URL'), i.get('ItemAttributes/Title'), i.get('ItemAttributes/Author'), @book]			#検索結果に追加
          end
        end
      end

    else
      return
    end
  end

  def reserve
    @ulib_id = params[:uketori_lib_id]
    @slib_id = params[:syozou_lib_id]
    @book_id = params[:book_id]
    @q = params[:q].to_i

    #@bookdata = Book.find_by_isbn_and_library_id(isbn10_to_13(@book.items[0].get('ItemAttributes/ISBN')),@slib_id)

    @resion = Reservation.new
    @resion.book_id = @book_id
    @resion.member_id = @current_member.id
    @resion.library_id = @ulib_id
    @resion.save

    if  @ulib_id == @slib_id && @q > AvailableQueue.where(book_id:@book_id).count + LendQueue.where(book_id:@book_id).count #&& ReserveQueue.where(book_id:@book.id).count == 0
      @avaq = AvailableQueue.new
      @avaq.reservation_id = @resion.id
      @avaq.member_id = @current_member.id
      @avaq.library_id = @ulib_id
      @avaq.book_id = @book_id
      @avaq.save
    else
      @resq = ReserveQueue.new
      @resq.reservation_id = @resion.id
      @resq.member_id = @current_member.id
      @resq.library_id = @ulib_id
      @resq.book_id = @book_id
      @resq.save
    end
    redirect_to :reservations
  end

  private
    def isbn10_to_13(isbn10)
    isbn13 = "978#{isbn10.to_s[0..8]}"
    #チェックディジット計算用
    check_digit = 0
    arr = isbn13.split(//)
    arr.each_with_index do |chr, idx|
      #Integer#even?はActiveSupportによる拡張
      check_digit += chr.to_i * (idx % 2 == 0 ? 1 : 3)
    end
    #総和を10で割ったものを10から引き、10の場合は0にする
    check_digit = (10 - (check_digit % 10)) % 10
    return "#{isbn13}#{check_digit}".to_i
  end

  def isbn13_to_10(isbn13)
    isbn10 = isbn13.to_s[3..11]
    check_digit = 0
    arr = isbn10.split(//)
    arr.each_with_index do |chr, idx|
      check_digit += chr.to_i * (10 - idx)
    end
    check_digit = 11 - (check_digit % 11)
    #計算結果が10になった場合、10の代わりにX(アルファベット大文字)
    #また、11になった場合は、0となる。
    case check_digit
    when 10
      check_digit = "X"
    when 11
      check_digit = 0
    end
    return "#{isbn10}#{check_digit}".to_i
  end


end
