class NewWalletService < BaseService
  def initialize(user: nil)
    @user = user
  end

  def call
    wallet = Wallet.new(generate_address)
    wallet.user = @user if @user.present?
    wallet.save
  end

  private

  def generate_address
    privkey, pubkey = Bitcoin::generate_key
    address = Bitcoin::pubkey_to_address(pubkey)

    {
      address: address,
      privkey: privkey,
      pubkey: pubkey
    }
  end
end