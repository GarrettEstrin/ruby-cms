class IndexController < ApplicationController
    def index 
        @advertiser = JSON.parse $redis.get('advertiser')
    end
end
