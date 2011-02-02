class EchoController < ApplicationController
  def echo
    render text: params[:t]
  end
end
