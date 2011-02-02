require 'reportula/discovered_models'
require 'reportula/apps/stat_index'
require 'reportula/apps/model_count'
require 'rack/mount'

module Reportula
  App = Rack::Builder.new do
    map "/reportula-vampire" do
      run(Rack::Mount::RouteSet.new do |set|
        set.add_route Apps::StatIndex.new, { path_info: %r{\A/stats\Z} }
        set.add_route Apps::ModelCount.new, { path_info: %r{\A/stats/(?<model_name>[a-zA-Z_][a-zA-Z0-9_]+)/count\Z} }
      end)
    end
  end

  class Vampire
    def initialize(app)
      @cascade = Rack::Cascade.new([App, app])
    end

    def call(env)
      @cascade.call(env)
    end
  end
end
