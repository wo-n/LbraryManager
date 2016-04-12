# coding: utf-8
class MembersController < ApplicationController
  before_filter :login_required, except: [:new, :create, :destroy]
  before_filter :admin_check, only: :index
  after_filter :member_check, only: :show


  def index
    @members = Member.order("id")
  end

  def show
    @member = Member.find(params[:id])
  end
  
  def new
    @member = Member.new
    @libraries = Library.order("id")
  end

  def create
    @libraries = Library.order("id")
    @member = Member.new(params[:member])
    if @member.save
      session[:member_id] = @member.id
      redirect_to @member, notice: "会員情報を登録しました。#{@member.id}"
      @mail = NoticeMailer.complete_registration(@member).deliver
    else
      render "new"
    end
  end

  def edit
    @member = Member.find(params[:id])
    @libraries = Library.order("id")
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to @member, notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @current_member.destroy
    redirect_to :root, notice: "会員情報を削除しました。"
  end

end
