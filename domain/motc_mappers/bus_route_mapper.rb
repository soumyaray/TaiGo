# frozen_string_literal: false

require_relative 'bus_sub_route_mapper.rb'

module TaiGo
  # Provides access to Bus Route data
  module MOTC
    # Data Mapper for Bus Route
    class BusRouteMapper
      def initialize(config, gateway = TaiGo::MOTC::Api)
        @config = config
        @gateway_class = gateway
        @gateway = @gateway_class.new(@config['MOTC_ID'].to_s,
                                      @config['MOTC_KEY'].to_s)
      end

      def load(city_name)
        @city_bus_route_data = @gateway.city_bus_route_data(city_name)
        load_several(@city_bus_route_data)
      end

      def load_several(city_bus_route_data)
        city_bus_route_data.map do |bus_route_data|
          BusRouteMapper.build_entity(bus_route_data)
        end
      end

      def self.build_entity(bus_route_data)
        DataMapper.new(bus_route_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(bus_route_data)
          @bus_route_data = bus_route_data
          # @subroutes_mapper = BusSubRouteMapper.new(gateway)
        end

        def build_entity
          Entity::BusRoute.new(
            id: id,
            authority_id: authority_id,
            name: name,
            depart_name: depart_name,
            destination_name: destination_name,
            owned_sub_routes: []
          )
        end

        private

        def id
          @bus_route_data['RouteUID']
        end

        def authority_id
          @bus_route_data['AuthorityID']
        end

        def name
          Name.new(@bus_route_data['RouteName']['En'],
                   @bus_route_data['RouteName']['Zh_tw'])
        end

        def depart_name
          Name.new(@bus_route_data['DepartureStopNameEn'],
                   @bus_route_data['DepartureStopNameZh'])
        end

        def destination_name
          Name.new(@bus_route_data['DestinationStopNameEn'],
                   @bus_route_data['DestinationStopNameZh'])
        end

        # def sub_routes
        #   @subroutes_mapper.load_several(@bus_route_data['SubRoutes'],
        #                                  @bus_route_data['RouteUID'])
        # end

        # Extract class name
        class Name
          attr_reader :english, :chinese

          def initialize(en, ch)
            @english = en
            @chinese = ch
          end
        end
      end
    end
  end
end
