require "sinatra/reloader"
require "httparty"
require "nats/client"
require "securerandom"
require "pry"

configure do
  nats = NATS.connect("nats")
  nats.on_error do |e|
    raise e
  end

  set :nats, nats
end

class Order
  attr_reader :state, :id

  def initialize
    @state = :pending
    @id = SecureRandom.uuid
  end

  def success!
    @state = :success
  end

  def failure!
    @state = :failure
  end
end
