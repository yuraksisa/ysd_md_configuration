require 'singleton'

module SystemConfiguration

  #
  # Company information
  #
  class CompanyInformation
    include Singleton

    def name
      SystemConfiguration::Variable.get_value( 'site.company.name', nil)
    end

    def document_id
      SystemConfiguration::Variable.get_value( 'site.company.document_id', nil)
    end

    def phone_number
      SystemConfiguration::Variable.get_value( 'site.company.phone_number', nil)
    end

    def email
      SystemConfiguration::Variable.get_value( 'site.company.email', nil)
    end

    def address_1
      SystemConfiguration::Variable.get_value( 'site.company.address_1', nil)
    end

    def address_2
      SystemConfiguration::Variable.get_value( 'site.company.address_2', nil)
    end

    def city
      SystemConfiguration::Variable.get_value( 'site.company.city', nil)
    end

    def state
      SystemConfiguration::Variable.get_value( 'site.company.state', nil)
    end

    def country
      SystemConfiguration::Variable.get_value( 'site.company.country', nil)
    end

    def zip
      SystemConfiguration::Variable.get_value( 'site.company.zip', nil)
    end

    def facebook
      SystemConfiguration::Variable.get_value( 'site.company.facebook', nil)
    end

    def twitter
      SystemConfiguration::Variable.get_value( 'site.company.twitter', nil)
    end

    def linkedin
      SystemConfiguration::Variable.get_value( 'site.company.linkedin', nil)
    end

    def instragram
      SystemConfiguration::Variable.get_value( 'site.company.instragram', nil)
    end

  end

end