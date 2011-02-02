module Reportula
  module Apps
    class StatIndex
      def call(env)
        [200, {"Content-Type" => "application/json"}, [{"stat_locations" => stat_locations}.to_json]]
      end

      def stat_locations
        DiscoveredModels.names.map do |n|
          "/reportula-vampire/stats/#{n.tableize}/count"
        end
      end
    end
  end
end
