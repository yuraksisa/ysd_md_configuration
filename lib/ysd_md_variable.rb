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
    
    #
    # Gets the value of the variable
    #
    # @param [String] name
    #   The variable name
    #
    # @param [Object] default_value
    #
    # @return [String] value
    #   The variable value or the default value if the variable is not defined
    #
    def self.get_value(name, default_value=nil)
    
      sysvar = Variable.get(name)
    
      return_value = if sysvar
                       sysvar.value
                     else
                       default_value
                     end      
    
    end
            
  end #Variable
end #SystemConfiguration