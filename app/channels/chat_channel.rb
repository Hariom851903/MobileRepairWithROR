class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

     def receive(data)
      Message.create(shop_id:
      data['shop_id'],profile_id:
      data['profile_id'],
      body: data['body']
      ) 
     end
end
