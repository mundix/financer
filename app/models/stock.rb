class Stock < ActiveRecord::Base

  # Vamos a definir un metodo que suaremso depues

  # Busca directamente en la DB
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  # Busca directamente en el API
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return looked_up_stock
    # En caso de que el nombre sea nil
    return nil unless looked_up_stock.name

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    # Vamos a definir el metodo price de aqui arriba
    new_stock
  end

  def price
    closing_price = StockQuote::Stock.quote(ticker).close
  #   Esto puede devolver nil
    return "#{closing_price} (Closing)" if closing_price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price

    'Unavailable'

  end

end
