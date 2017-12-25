class TxesController < ApplicationController
  def index
    @txes = Tx.page(params[:page])
  end

  def show
    @tx = Tx.find_by(tx_hash: params[:id])
  end
end
