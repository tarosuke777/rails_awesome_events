class StatusController < ApplicationController
    skip_before_action :authenticate

    def index 
        json.status "ok"
    end
end
