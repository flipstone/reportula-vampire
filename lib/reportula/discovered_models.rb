module Reportula
  module DiscoveredModels
    def self.names
      ActiveRecord::Base.connection.tables.map do |t|
        t.classify.underscore
      end.select do |f|
        File.exist?(File.join(Rails.root, 'app', 'models', "#{f}.rb"))
      end
    end
  end
end
