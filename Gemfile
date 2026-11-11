source 'https://rubygems.org'

# Don't forget to update the version in the dockerfile when updating this
gem 'bundler', '4.0.24'

# Main site dependencies
gem 'awestruct', '0.6.7'
gem 'base64'          # em-websocket requires this, but Ruby 4 no longer provides it by default
gem 'ostruct'         # Awestruct requires this, but Ruby 4 no longer provides it by default
gem 'syslog'          # logging loads this, but Ruby 4 no longer provides it by default
gem 'sass'
gem 'json'
gem 'haml', '< 6.0'    # Haml 6 would require udpating our filter registration code
gem 'uglifier'         # Ruby wrapper for UglifyJS JavaScript compressor
gem 'cssminify'        # CSS compression using YUI compressor
gem 'htmlcompressor'   # Adds in HTML minification, helps remove the warning on awestruct startup
gem 'redcarpet'        # Markdown processing
gem 'asciidoctor'      # Asciidoc renderer
gem 'i18n'             # Deal with non Ascii names
gem 'htmlentities'     # Escape/unescape HTML entities
gem 'nokogiri'         # HTML parser
gem 'logging'

## Non Windows
gem 'mini_racer', :platforms => :ruby

## Windows
gem 'win32-open3-19', :platforms => :windows

# Test dependencies
gem 'rspec'

# For previews
gem 'webrick'

# To enable guard and livereload
gem 'guard'
gem 'guard-livereload'
gem 'yajl-ruby'

# Debugging
gem 'pry-byebug'
gem 'tracer'

