class StocksController < ApplicationController
  def search
    if params[:stock]
      # Busca directo en la DB
      @stock = Stock.find_by_ticker(params[:stock])
      # En caso de que no devuelva un valor buscado, entonces has un
      # nueva busqueda al api, Esto es si no existe en la DB
      @stock ||= Stock.new_from_lookup(params[:stock])
    end

    if @stock
      # Esto me genera la salida del JSON
      # Esta es una buena manera de saber si esta funcionando
      # render json: @stock
      # -> "_name.html.erb" is a partial
      render partial: 'lookup'
    else
      render status: :not_found, nothing:  true;
    end
  end
end