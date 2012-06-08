module SystemConfiguration
  #
  # It represents a system variable which is used to configure applications, blocks, ...
  #
  class Variable
    include DataMapper::Resource
    
    storage_names[:default] = "conf_variable"
    
    property :name, String, :field => 'name', :length => 128, :key => true # The variable name
    property :value, String, :field => 'value', :length => 256 # The variable value
    property :module, String, :field => 'module', :length => 64 # Which defines the variable
    property :description, String, :field => 'description', :length => 256 # The variable description
    
  end #Variable
end #SystemConfiguration