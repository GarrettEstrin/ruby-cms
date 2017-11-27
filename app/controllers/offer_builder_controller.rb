class OfferBuilderController < ApplicationController
    def index
        $offers = JSON.parse $redis.GET('offers')
        $new_offer = String.new
        # $redis.SET('offers', {'att'=> '1'}.to_json)
    end

    def add_offer 
        $offers = JSON.parse $redis.GET('offers')
        $offers[params[:offer_name]] = ""
        $redis.set('offers', $offers.to_json)
        redirect_to offerbuilder_path
    end 
end
