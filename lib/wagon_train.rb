require 'sequel'
require 'dry-equalizer'

module WagonTrain
  module Util
    def self.underscore_string(string)
      string.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr("-", "_")
        .downcase
    end
  end

  def self.lit(*args)
    ::Sequel.lit(*args)
  end
end

require 'wagon_train/utils/visitor'
require 'wagon_train/utils/string_collector'

require 'wagon_train/entities/column'
require 'wagon_train/entities/table'
require 'wagon_train/entities/enum_type'
require 'wagon_train/entities/schema'

require 'wagon_train/dsl'
require 'wagon_train/sequel'
require 'wagon_train/difference'
require 'wagon_train/migration'
require 'wagon_train/verify'

