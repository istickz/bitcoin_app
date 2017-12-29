# bitcoin_app

## Prepare Database
```
  bin/rails db:create
  bin/rails db:migrate
```
## Run Bitcoin monitor
  `bin/bintcoin_monitor`
## Run Rails application
```
  bin/rails s
```

Blocks List: http://localhost:3000/blocks

Transactions List: http://localhost:3000/txes


```
Bitcoin.network = :testnet3
include Bitcoin::Builder

user1 = User.create(email: 'wallet1@example.com', password: 'wallet1@example.com', password_confirmation: 'wallet1@example.com')
NewWalletService.new(user: user1).call

user2 = User.create(email: 'wallet2@example.com', password: 'wallet2@example.com', password_confirmation: 'wallet2@example.com')
NewWalletService.new(user: user2).call


wallet1 = user1.wallets.first
wallet2 = user2.wallets.first


# Отправляем 1.3BTC на w1 через https://testnet.manu.backend.hamburg/faucet

# Sent! TX ID: 5d8d1fc7dfbaa0f0cfa3a7e30c62b1935095fd27f1b2a6cb3b4947899676addd

# Находим у себя транзакцию, где нам прислали 1.3BTC
# В принципе можно и искать любой непотраченный выход, но и транзакция сойдет
tx = Tx.find_by tx_hash: '5d8d1fc7dfbaa0f0cfa3a7e30c62b1935095fd27f1b2a6cb3b4947899676addd'

# Проверяем баланс нашего кошелька

wallet1.balance_btc
# => "1.30000000"

# Отлично, теперь отправим 0.2BTC на наш второй кошелек
# Находим индекс выхода на 130000000

prev_out_index = tx.tx_outs.index{|out| out.value == 130000000 &&  out.address == wallet1.address}
prev_hash = tx.tx_hash

prev_tx = Bitcoin::P::Tx.from_hash tx.to_hash

key = Bitcoin::Key.new(wallet1.privkey, wallet1.pubkey)

satoshi2btc = -> (btc) {btc * 10**8}

new_tx = build_tx do |t|
  # Создаем новый вход со ссылкой на предыдущий выход транзакции
  t.input do |i|
    i.prev_out prev_tx
    i.prev_out_index prev_out_index
    i.signature_key key
  end

  # Создаем выход 0.1 BTC на адрес w2
  t.output do |o|
    o.value satoshi2btc[0.2] # 0.2 BTC 
    o.script {|s| s.recipient wallet2.address }
  end
  # У нас остается 1.1BTC
  # Берем комиссиию 0.01
  t.output do |o|
    o.value satoshi2btc[1.09] 
    o.script {|s| s.recipient key.addr }
  end
end


# Получаем hex транзакции
hex = new_tx.to_payload.unpack("H*")[0]

#Отправим транзакцию в сеть

$ bin/bitcoin_monitor send_hex=0100000001ddad76968947493bcba6b2f127fd955093b1620ce3a7a3cff0a0badfc71f8d5d000000008a47304402201b38f10ce6744ec7f5a2fa21e943cb1ade3d64bd7a73e70e1f1f4c4ad7908aad022007a413a8e8c4425cde4c8db7ce65c41d070382822ae94f7c22db03ad8541fa280141041222b58a9c3508f442cc9842d07ab38a39833fd71c8eee12d61e62aba68839e18585afb5f05054b08b5258e16cf39ad07e41aa8f74822aa596bead065e9335d2ffffffff02002d3101000000001976a914cae9842080f87485529d74ae6df5246e5f9a517288ac40357f06000000001976a9147f3e1f904c4e8d4cecbc1223b984f66fba90e31788ac00000000


```
