## Work around Mongrel source file: mongrel-1.1.5/lib/mongrel/rails.rb: 148
##        require 'dispatcher'

module ActionController
  class AbstractRequest
    def relative_url_root=
    end
  end
end
