class TicketsController < ApplicationController
    def new
        raise ActionController::RoutingError, "not login"
    end

    def create
        event = Event.find(params[:event_id])
        @ticket = current_user.tickets.build do |t|
            t.event = event
            t.comment = params[:ticket][:comment]
        end
        if @ticket.save
            redirect_to event, notcie: "this event joined"
        end
    end

    def destroy
        ticket = current_user.tickets.find_by!(event_id: params[:event_id])
        ticket.destroy!
        redirect_to event_path(params[:event_id]), notcie: "This event is canceled"
    end
end
