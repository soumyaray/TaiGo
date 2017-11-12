# frozen_string_literal: false

require 'dry-struct'

module TaiGo
  module Entity
    # Domain entity object for Stop Of Route
    class StopOfRoute < Dry::Struct
      attribute :sub_route_uid, Types::Strict::String # maybe change to stop_of_route_id?
      attribute :stop_uid, Types::Strict::String
      attribute :stop_boarding, Types::Strict::Int
      attribute :stop_sequence, Types::Strict::Int
    end
  end
end
