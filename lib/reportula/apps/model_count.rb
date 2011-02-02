module Reportula
  module Apps
    class ModelCount
      def call(env)
        model_name = env["rack.routing_args"][:model_name]
        return [404, {}, []] unless DiscoveredModels.names.include?(model_name.singularize)
        model_class = model_name.classify.constantize

        [
          200,
          {"Content-Type" => "application/json"},
          [
            {
              value: model_class.count,
              unit: model_class.name,
              measure: "#{model_class} Count"
            }.to_json
          ]
        ]
      end
    end
  end
end
