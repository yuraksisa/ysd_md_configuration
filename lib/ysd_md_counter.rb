require 'data_mapper' unless defined?DataMapper
require 'ysd_md_yito' unless defined?Yito::Model::Finder

module SystemConfiguration

  class Counter
    include DataMapper::Resource
    extend Yito::Model::Finder

    storage_names[:default] = 'conf_counters'

    property :id, Serial
    property :name, String, length: 128
    property :serie, String, length: 10
    property :value, Integer, default: 0

  end
end
