#coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    member = Member.authenticate(params[:name], params[:password])
    if member
      session[:member_id] = member.id
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_back_or_default(:root)
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end

  private
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || :root)
    session[:return_to] = nil
  end
end
