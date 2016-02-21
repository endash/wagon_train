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
end

require 'wagon_train/visitor'
require 'wagon_train/column'
require 'wagon_train/table'
require 'wagon_train/enum_type'
require 'wagon_train/schema'
require 'wagon_train/dsl'
require 'wagon_train/sequel'
require 'wagon_train/difference'
require 'wagon_train/string_collector'
require 'wagon_train/migration'
require 'wagon_train/verify'

