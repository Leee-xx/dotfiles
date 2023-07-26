begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError => e
  warn "Couldn't load awesome_print: #{e.message}"
end

IRB.conf[:USE_AUTOCOMPLETE] = false
