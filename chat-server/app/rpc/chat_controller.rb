# frozen_string_literal: true

##
# Represents a product service that is used for illustrating server calls
#
class ChatController < Gruf::Controllers::Base
  bind ::Rpc::Chat::Service

  def initialize(args)
    super(**args)
  end

  ##
  # Illustrates a client streaming call
  #
  # @return [Rpc::CreateProductsResp]
  #
  def save_message
    message = Message.from_proto(request.message)
    message.save!

    Rpc::MessageResponse.new
  rescue => e
    set_debug_info(e.message, e.backtrace[0..4])
    fail!(:internal, :internal, "ERROR: #{e.message}")
  end

  def get_location
    User.find(request.message.user_id)

    return enum_for(:get_location) unless block_given?

    rand(100).downto(0) do |i|
      sleep 1
      response = Rpc::LocationResponse.new(
        timestamp: Time.now.to_i,
        distance: i
      )
      yield response
    end
  rescue ActiveRecord::RecordNotFound => _
    fail!(:not_found, :not_found, "User not found")
  rescue => e
    set_debug_info(e.message, e.backtrace[0..4])
    fail!(:internal, :internal, "ERROR: #{e.message}")
  end
end
