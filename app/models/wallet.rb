class Wallet < ApplicationRecord
  paginates_per 50

  def balance
    query = <<-SQL.strip_heredoc
    select 
      sum(tx_outs.value)
    from tx_outs
    left join (
      select
        tx_outs.id
      from tx_ins
      join txes on txes.tx_hash = tx_ins.prevout_hash
      join blocks_txes on blocks_txes.tx_id = txes.id
      join tx_outs on tx_outs.id = (
          select id from tx_outs
          where tx_outs.tx_id = txes.id
          order by created_at desc
          offset tx_ins.n limit 1
      )
    ) as spent_tx_outs on spent_tx_outs.id = tx_outs.id
    where tx_outs.address = '#{address}'      
    and spent_tx_outs.id is null
    SQL
    ActiveRecord::Base.connection.execute(query).to_a.first['sum']
  end


  def balance_btc
    sprintf "%.8f", (balance.to_f / 10**8)
  end
end
