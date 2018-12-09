require 'data_mapper' unless defined?DataMapper
require 'ysd_md_yito' unless defined?Yito::Model::Finder

module SystemConfiguration
  #
  # It represents a system variable which is used to configure applications, blocks, ...
  #
  class Variable
    include DataMapper::Resource
    extend Yito::Model::Finder

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
    
    #
    # Sets the value of the variable
    #
    # @param [String] The variable name
    # @param [String] The variable value
    # @param [Hash] options
    # 
    # @return [Variable]
    #
    def self.set_value(name, value, opts={})
      
      variable_module = opts[:module]
      variable_description = opts[:description]

      if variable = Variable.get(name)
        variable.value = value.to_s
        variable.module = variable_module if variable_module
        variable.description = variable_description if variable_description
        variable.save
      else
        variable = Variable.create({:name => name, :value => value.to_s,
          :module => variable_module, :description => variable_description})
      end

      return variable

    end

  end #Variable
end #SystemConfiguration