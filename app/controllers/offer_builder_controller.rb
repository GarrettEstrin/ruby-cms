class OfferBuilderController < ApplicationController
    def index
        $offers = JSON.parse $redis.GET('offers')
        $new_offer = String.new
        $offer_details = Hash.new
        $offers.each do |key, value|
            $offer_details[key] = JSON.parse $redis.GET('offer:' + key)
        end
        # $redis.SET('offers', {'att'=> '1'}.to_json)
    end

    def add_offer 
        $offers = JSON.parse $redis.GET('offers')
        # $offer_details = JSON.parse $redis.SCAN(0, 'MATCH', 'offer:*')
        $offers[params[:offer_name]] = ""
        $redis.set('offers', $offers.to_json)
        $offer = {"number" => "888-888-888"}
        $redis.set('offer:' + params[:offer_name], $offer.to_json)
        redirect_to offerbuilder_path
    end 
end
