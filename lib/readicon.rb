# Public : facade providing Readicon operations
#
module Readicon
  require "readicon/mongo_store"
  require "readicon/item"
  require "readicon/item_state"
  require "readicon/item_states"
  require "readicon/item_store"
  require "readicon/read_state_store"
  require "readicon/coordinator"

  class << self

    # Public : setup method for the Readicon gem
    #
    # Readicon.setup do |config|
    #   config.connection_profile = "mongodb://localhost/readicon_test"
    # end
    #
    def setup
      yield self
      @connection = Mongo::MongoClient.from_uri(Readicon.connection_profile)
      @database = URI.parse(Readicon.connection_profile).path.gsub(/^\//, '')
    end

    # Public : connection profile for the Mongo store to be used
    attr_accessor :connection_profile
    attr_reader :connection, :database

    # Public : record that an item was created
    #
    # user      - String identifying the user who created the item
    # id        - String uniquely identifying the item
    # at        - Time the item was created
    #
    # Returns nothing
    def item_created(user, id, at)
      _coordinator.item_created(user, id, at)
    end

    # Public : record that an item was updatd
    #
    # user      - String identifying the user who updated the item
    # id        - String uniquely identifying the item
    # at        - Time the item was updated
    #
    # Returns nothing
    def item_updated(user, id, at)
      _coordinator.item_updated(user, id, at)
    end

    # Public : record that an item was read
    #
    # user      - String identifying the user who read the item
    # id        - String uniquely identifying the item
    # at        - Time the item was read
    #
    # Returns nothing
    def item_read(user, id, at)
      _coordinator.item_read(user, id, at)
    end

    # Public : get user ItemState for a series of items
    #
    # user      - String identifying the user
    # ids       - Array of Strings identifying the items to get state for
    #
    # Returns Enumerable of ItemState
    def get_states(user, ids)
      _coordinator.get_states(user, ids)
    end

    # Public : get user ItemState
    #
    # user      - String identifying the user
    # ids       - String identifying the item to get state for
    #
    # Returns an ItemState or nil
    def get_state(user, id)
      _coordinator.get_state(user, id)
    end

  private
    def _coordinator
      @_coordinator ||= Coordinator.new
    end

  end
end