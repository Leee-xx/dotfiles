begin
  require 'amazing_print'
  AmazingPrint.irb!
rescue LoadError => e
  warn "Couldn't load amazing_print: #{e.message}"
end

IRB.conf[:USE_AUTOCOMPLETE] = false
