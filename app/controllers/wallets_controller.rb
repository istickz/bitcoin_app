class WalletsController < ApplicationController
  def index
    @wallets = Wallet.page(params[:page])
  end

  def show
    @wallet = Wallet.find(params[:id])
  end
end
