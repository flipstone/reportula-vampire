class EchoController < ApplicationController
  def echo
    render text: (params[:t] || "Test Rails App Default Echo")
  end
end
