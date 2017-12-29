class BlocksController < ApplicationController
  def index
    @blocks = Block.page(params[:page])
  end

  def show
    @block = Block.find(params[:id])
  end
end
