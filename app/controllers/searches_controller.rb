class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1HHAFFCNMUVO244XIOPKWPSLPBGTKTRMZSRVTARYBDW1OFGZ'
      req.params['client_secret'] = 'SUBR0MGC2F1P12ZOXCPHRXJLG0YS34H3D4I3YCM0TEGIT0MM'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 199
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
end
