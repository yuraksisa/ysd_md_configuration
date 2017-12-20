require 'singleton'

module SystemConfiguration

  #
  # Main application settings
  #
  class Settings
    include Singleton

    #
    # Get the default currency (ISO 4217)
    #
    # See https://es.wikipedia.org/wiki/ISO_4217
    #
    def default_currency
      "EUR"
    end

    #
    # Format an amount using the formatter
    #
    def format_amount(amount, locale)
      l = R18n.locale(locale)
      l.localize(date, amount)
    end

    #
    # Format the date using the formatter
    #
    def format_date(date, format, locale)
      l = R18n.locale(locale)
      case format
        when :short
          l.localize(date, short_date_format)
        when :default
          l.localize(date, default_date_format)
        when :extended
          locale == 'en' ? l.localize(date, extended_date_format_with_ordinalized_day(date.day)).split(' ').map!{|item| item.capitalize}.join(' ') : l.localize(date, extended_date_format).split(' ').map!{|item| item.capitalize}.join(' ')
        when :full
          locale == 'en' ? l.localize(date, full_date_format_with_ordinalized_day(date.day)).split(' ').map!{|item| item.capitalize}.join(' ') : l.localize(date, full_date_format).split(' ').map!{|item| item.capitalize}.join(' ')
        else
          l.localize(date, default_date_format)
      end
    end

    protected

    # -------------------------- Amount formats --------------------------------------

    #
    # Get the default currency format to be used in %
    #
    def default_currency_format
      "%.2f"
    end

    # ------------------------ Date formats ------------------------------------------

    #
    # Date format using two digits for the year
    #
    def short_date_format
      "%d/%m/%y"
    end

    #
    # Default date format using four digits for the year
    #
    def default_date_format
      "%d/%m/%y"
    end

    #
    # Extended date format
    #
    def extended_date_format
      "%d %B %Y"
    end

    #
    # Extended date format with ordinalized day
    #
    def extended_date_format_with_ordinalized_day(day)
      "#{ordinalize(day)} %B %Y"
    end

    #
    # Full date format
    #
    def full_date_format
      "%A, %d %B %Y"
    end

    #
    # Full date format
    #
    def full_date_format_with_ordinalized_day(day)
      "%A, #{ordinalize(day)} %B %Y"
    end

    #
    # Ordinalize a day
    #
    def ordinalize(day)
      case day.to_s[-1]
        when "1"
          "#{day}st"
        when "2"
          "#{day}nd"
        else
          "#{day}th"
      end
    end


  end

end