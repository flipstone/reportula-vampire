module Reportula
  class Vampire
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["PATH_INFO"] =~ %r{\A/reportula-vampire/}
        env["PATH_INFO"] =~ %r{/stats/([^/]+)/count}
        model_class = begin
                        $1.classify.constantize
                      rescue NameError
                        return ["404", {}, []]
                      end

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
      else
        @app.call env
      end
    end
  end
end
