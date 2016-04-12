# coding: utf-8
class ReservationsController < ApplicationController
  def index
    @availablequeue = AvailableQueue.order("id")
    @reservations = Reservation.order("id")
    @reservequeue = ReserveQueue.order("id")
  end
  
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def rtoaEdit #reserve_queue to available_queue Edit
		@libraries = Library.order("id")
  end

  #司書に、本の:isbnと本の所蔵館(:library_id)を入力してもらう
  def rtoaUpdate
		@isbn = params[:isbn]
		@book = Book.where("isbn = ? AND library_id = ?", @isbn, params[:library_id])[0]
		@reserve = ReserveQueue.where("book_id = ?", @book.id).order("id")[0]
		if @book.quantity > ((LendQueue.where("book_id = ?", @reserve.book_id).count) + (AvailableQueue.where("book_id = ?", @reserve.book_id).count))
			@available = AvailableQueue.new
			@available.reservation_id = @reserve.reservation_id
			@available.member_id = @reserve.member_id
			@available.book_id = @reserve.book_id
			@available.library_id = @reserve.library_id
			if @available.save
                                @reserve.destroy
				redirect_to :reservations_path, notice: "#{@book.id}を予約状態から貸出可能状態に変更しました"
			else
				render "rtoaEdit"
			end
		else
			render "rtoaEdit"
		end
  end

end
