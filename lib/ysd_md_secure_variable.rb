require 'data_mapper' unless defined?DataMapper
require 'dm-ysd-encrypted' unless defined?DataMapper::Property::Encrypted
require 'ysd_md_yito' unless defined?Yito::Model::Finder

module SystemConfiguration
  #
  # A variable which value is stored encrypted on the database
  #
  # It uses RSA to crypt the variable through dm-ysd-encrypted
  #
  # In order to work you need to configure Crypto. 
  #
  # Example 1: Creating the key programatically - FOR TESTING -
  #
  #  require 'openssl'
  #  require 'digest/sha2'
  #
  #  rsa_key = OpenSSL::PKey::RSA.generate(2048)
  #
  #  Crypto.configure({:rsa_key => rsa_key,
  #    :aes_key => rsa_key.public_encrypt(Digest::SHA2.new(256).digest('my_password')),
  #    :aes_iv => rand.to_s})
  #
  # Example 2: Using environment variables - IN PRODUCTION -
  # https://devcenter.heroku.com/articles/config-vars
  #
  #  You can define three environment variables, CRYPT_RSA_KEY, CRYPT_AES_KEY and
  #  CRYPT_AES_IV
  #
  #  Crypto.configure({:rsa_key => ENV['CRYPT_RSA_KEY'], 
  #   :aes_key => ENV['CRYPT_AES_KEY'], 
  #   :aes_iv => ENV['CRYPT_AES_IV']})
  #
  # http://stuff-things.net/2007/06/11/encrypting-sensitive-data-with-ruby-on-rails/
  #
  class SecureVariable
    include DataMapper::Resource
    extend Yito::Model::Finder

    storage_names[:default] = 'conf_secure_variables'

    property :name, String, :field => 'name', :length => 128, :key => true
    property :value, Encrypted, :field => 'value', :length => 1024
    property :module, String, :field => 'module', :length => 64
    property :description, String, :field => 'description', :length => 256

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
    
      sysvar = SecureVariable.get(name)
    
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

      if variable = SecureVariable.get(name)
        variable.value = value.to_s
        variable.module = variable_module if variable_module
        variable.description = variable_description if variable_description
        variable.save
      else
        variable = SecureVariable.create(:name => name, :value => value.to_s, 
          :module => variable_module, :description => variable_description)
      end

      return variable

    end


  end
end
