# frozen_string_literal: true

module TaiGo
    module Database
      # Object Relational Mapper for BusStop Entities
      class BusStopOrm < Sequel::Model(:stops)
    
        many_to_many :routes,
                     join_table: :stops_of_routes,
                     left_key: :stop_uid, right_key: :route_uid
  
        plugin :timestamps, update_on_create: true
      end
    end
  end
  