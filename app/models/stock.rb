# NOTA IMPORTANTE ESTE API ES INESTABLE
# Hay que hacer varios REFRESH ojo con eso
# Hay que monitorear todas las variables.
class Stock < ActiveRecord::Base

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    # return looked_up_stock
    return nil unless looked_up_stock.name
    # symbol = looked_up_stock.symbol
    # name = looked_up_stock.name
    # looked_up_stock
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
  #   Ahora vamos a crear el price method de esta misma clase, que no tenemos
    new_stock.last_price = new_stock.price(looked_up_stock)
    new_stock
  #   looked_up_stock.open
  end

#   Definamos el price method
  def price(stock)
    # return ticker
    # closing_price = StockQuote::Stock.quote(ticker).close
    closing_price = stock.close
    return "#{closing_price} (Closing)" if closing_price # Si no es nil

    # opening_price  = StockQuote::Stock.quote(ticker).open
    opening_price  = stock.open
    return "#{opening_price} (Opening)" if opening_price #Si no es nil

  #   En otraspalabras es no disponible
    "No disponible"
  end

#   Ahora vamos a def otro metodo llamado find_by_ticker(symbol)

end
