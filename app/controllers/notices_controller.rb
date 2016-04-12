class NoticesController < ApplicationController
  def index
    @notices = Notice.order("id")
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
