class OfferBuilderController < ApplicationController
    def index
        if $redis.GET('offers');
            $offers = JSON.parse $redis.GET('offers')
            $offer_details = Hash.new
            $offers.each do |key, value|
                $offer_details[key] = JSON.parse $redis.GET('offer:' + key)
            end
        end
        $new_offer = String.new
        puts $offer_details
    end

    def add_offer
        # check if any offers exist
        if $redis.GET('offers')
            $offers = JSON.parse $redis.GET('offers')
        else
            $offers = Hash.new
        end
        # check if property tracking exists
        if $redis.GET('properties')
            $properties = JSON.parse $redis.GET('properties')
        else
            $properties = Hash.new
            $properties["number"] = "888-888-8888"
            $properties["name"] = ""
            $redis.set("properties", $properties.to_json)
        end
        # set offer
        $offers[params[:offer_name]] = ""
        $redis.set('offers', $offers.to_json)
        # set properties
        $properties["name"] = params[:offer_name]
        $redis.set("offer:" + params[:offer_name], $properties.to_json)
        redirect_to offerbuilder_path
    end 

    def edit_offer
        puts params
        if $redis.GET("offer:" + params[:offer_name])
            puts "offer found"
            $offer = JSON.parse $redis.GET("offer:" + params[:offer_name])
        else
            redirect_to offerbuilder_path            
        end
            $offer[params[:prop_name]] = params[params[:prop_name]]
            $redis.SET("offer:" + params[:offer_name], $offer.to_json)
        redirect_to offerbuilder_path
    end
    
end
