$:.unshift File.dirname(__FILE__)
require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'active_resource/detailed_log_subscriber'
require 'shopify_api/limits'
require 'shopify_api/api_version'
require 'shopify_api/meta'
require 'active_resource/json_errors'
require 'shopify_api/paginated_collection'
require 'shopify_api/disable_prefix_check'

module ShopifyAPI
  include Limits
end

require 'shopify_api/events'
require 'shopify_api/metafields'
require 'shopify_api/countable'
require 'shopify_api/resources'
require 'shopify_api/session'
require 'shopify_api/message_enricher'
require 'shopify_api/connection'
require 'shopify_api/pagination_link_headers'
require 'shopify_api/graphql'
require 'shopify_api/graphql/railtie' if defined?(Rails)

if ShopifyAPI::Base.respond_to?(:connection_class)
  ShopifyAPI::Base.connection_class = ShopifyAPI::Connection
else
  require 'active_resource/connection_ext'
end

############################################
### Add methods that missing in ruby 2.2 ###
############################################

### Runtine dependency (activeresource and graphql-client) uses some method from ruby 2.4 so we need to port ones

class String
  def -@
    self.frozen? ? self : self.clone.freeze
  end
end

class Regexp
  def match?(str)
    !!match(str)
  end
end

class Fixnum
  def clone
    self
  end
end

class TrueClass
  def clone
    self
  end
end

class FalseClass
  def clone
    self
  end
end

class NilClass
  def clone
    self
  end
end
############################################
############################################
############################################

