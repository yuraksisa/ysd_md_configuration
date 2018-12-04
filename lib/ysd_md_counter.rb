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
    
    #
    # Get the series
    #
    def self.series(name)
   
       query = <<-SQL
                select distinct(serie) from conf_counters where name = ?
              SQL
       repository.adapter.select(query, name)

    end 	

    #
    # Get the next value
    #
    def self.next_value(name, serie)
      if counter = get_counter(name, serie)
        next_value = counter.value + 1
        counter.update(value: next_value)
        return next_value
      end
    end 	

    #
    # Get a counter by its name and serie
    #
    def self.get_counter(name, serie)
      if serie.nil? or serie.empty?	
        SystemConfiguration::Counter.first(name: name, serie: nil)
      else
      	SystemConfiguration::Counter.first(name: name, serie: serie)
      end  
    end
    
    #
    # Set a counter value
    #
    def self.set_counter(name, serie, value)
      if counter = get_counter(name, serie)
        counter.update(value)
      end
    end 	


  end
end
