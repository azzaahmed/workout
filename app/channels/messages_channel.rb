class MessagesChannel < ApplicationCable::Channel
	# server side of channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

#called in messages.coffee
    def checkIn(data)
    room_id = "#{data['room_id']}"
    stream_from "messages_room_#{room_id}"  #create the channel 
  end
  
  def checkOut
    stop_all_streams
  end
  
end
