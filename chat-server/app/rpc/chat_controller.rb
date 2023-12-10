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
end
