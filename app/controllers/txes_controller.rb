class TxesController < ApplicationController
  def index
    @txes = Tx.all
  end

  def show
    @tx = Tx.find(params[:id])
  end
end
