#client side
App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    #connect lama bad5ol fel lounge
    #taken from exercise/index.html
    roomId = $("#chat-box").data("room-id")
    #checkIn method below
    @checkIn(roomId)

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    #message-row is the class of message block in message partial
    #check how many messages if more than 10 delete the first one and display the latest 10 messages
    posts = $(".message-row").length
    if posts == 10
      $(".message-row").first().remove()
    
    # bazawed al recieved data fel div of id chat-box hala2y fel exercise/index.html w bafady al text- 
    #field empty string  
    $("#chat-box").append(data)
    $("#message-field").val('')
    
    
  checkIn: (roomId) ->
    if roomId
      # call the checkIn method we defined in the server side messages_channel.rb
      @perform 'checkIn', room_id: roomId
    else
      @perform 'checkOut'
