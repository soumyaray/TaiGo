# frozen_string_literal: true
require_relative 'name_representer'

module TaiGo
  # Representer class for converting BusRoute attributes to json
  class SubRouteRepresenter < Roar::Decorator
    include Roar::JSON

    property :sub_route_uid
    property :route_id
    property :sub_route_name, extend: NameRepresenter
    property :headsign
    property :direction
  end
end
