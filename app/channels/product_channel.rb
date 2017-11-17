class ProductChannel < ApplicationCable::Channel
  def subscribed
    # stream_from 'product_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def listen(data)
    product_id = data['product-id']
    stop_all_streams
    stream_for product_id if product_id
  end
end
