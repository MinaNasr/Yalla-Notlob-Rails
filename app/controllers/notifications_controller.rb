class NotificationsController < ApplicationController

    def get_all_notifications
        if User.find_by_id(params[:user_id])
            @notifications = Notification.where(user_id: params[:user_id])
            render json: @notifications
        else
            render json: {message: "failed"}
        end        
    end

    def join_order
        params.require(:notification).permit! 

        if User.find_by_id(params[:user_id])
            @notif = Notification.create({name: params[:name], order_id: params[:order_id],
                                user_id: params[:user_id], type: "join"})
            if @notif.save
                ActionCable.server.broadcast "notifications_#{params[:user_id]}",{
                message: "join",
                order_id: params[:order_id],
                name: params[:name]
                }                       
            end                    
            render json: {message: "success"}
        else
            render json: {message: "failed"}
        end
    end

    def view_notifications
        if User.find_by_id(params[:user_id])
            Notification.where(user_id: params[:user_id]).update_all(viewed: true) 
            render json: { message: "success"}
        else
            render json: { message: "failed"}
        end
    end 
    
    def get_new_notifications
        if User.find_by_id(params[:user_id])
            @notifs = Notification.where(user_id: params[:user_id], viewed: false)
            @notifiacations = Notification.where(user_id: params[:user_id]).last(2)
            count = @notifs.length
            render json: {status: true, count: count, notifications: @notifiacations}
        else
            render json: {message: "failed"}
        end
    end 
end
