class NewWalletService < BaseService
  def call
    wallet = Wallet.new(generate_address)
    wallet.save
    wallet
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