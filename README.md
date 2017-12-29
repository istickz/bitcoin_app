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

wallet1 = NewWalletService.call
wallet2 = NewWalletService.call

# Отправляем 1.3BTC на wallet1 через https://testnet.manu.backend.hamburg/faucet

# Sent! TX ID: 4c987db8ff5ae655931d014516cd9806bc75c3bbb0eac71e3ac1cd0d124233ae

# Находим у себя транзакцию, где нам прислали 1.3BTC
# В принципе можно и искать любой непотраченный выход, но и транзакция сойдет
tx = Tx.find_by tx_hash: '4c987db8ff5ae655931d014516cd9806bc75c3bbb0eac71e3ac1cd0d124233ae'

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
"0100000001ae3342120dcdc13a1ec7eab0bbc375bc0698cd1645011d9355e65affb87d984c000000008a4730440220501eadd3addf6f803bfa4a122f53afee735df3d083a0ec37ac3f190c3fbd925f02203d7f0e9fd334d97e2225f1947a261077a0b6796c85aef78a457fa4d3fdbbe7c30141040fcc1a14462416095bd6d806cdcfa4d2bbd7a02678cf83f1b08c56a94f95295473c227e58d8ceb8af887c5f12ec0c6d4e93b425cc696f0c846f80f49ead2dc63ffffffff02002d3101000000001976a914638653d21fb22b39c2a95db6e19f16739082c3c588ac40357f06000000001976a914bbc5664f9e98e60c8d7334e481cd65d45ed5097088ac00000000"


#Отправим транзакцию в сеть

$ bin/bitcoin_monitor send_hex=0100000001ae3342120dcdc13a1ec7eab0bbc375bc0698cd1645011d9355e65affb87d984c000000008a4730440220501eadd3addf6f803bfa4a122f53afee735df3d083a0ec37ac3f190c3fbd925f02203d7f0e9fd334d97e2225f1947a261077a0b6796c85aef78a457fa4d3fdbbe7c30141040fcc1a14462416095bd6d806cdcfa4d2bbd7a02678cf83f1b08c56a94f95295473c227e58d8ceb8af887c5f12ec0c6d4e93b425cc696f0c846f80f49ead2dc63ffffffff02002d3101000000001976a914638653d21fb22b39c2a95db6e19f16739082c3c588ac40357f06000000001976a914bbc5664f9e98e60c8d7334e481cd65d45ed5097088ac00000000

```
