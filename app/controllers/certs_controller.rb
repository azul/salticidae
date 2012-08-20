class CertsController < ApplicationController

  # GET /cert
  def show
    @cert = Cert.pick_from_pool
    send_data @cert.zipped :filename => @cert.zipname
  end

end
