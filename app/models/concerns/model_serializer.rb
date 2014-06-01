require 'active_support/concern'

module ModelSerializer
  extend ActiveSupport::Concern
  attr_accessor :ms_options

  def to_ms
    model_id = id
    model_name = self.class.name
    model_options = @ms_options.to_s if @ms_options
    model_options = model_options ? ",#{model_options}" : ''
    "#<#{model_name}:#{model_id}#{model_options}>"
  end

  def ms_options(attrs)
    return @ms_options = self.attributes.slice(*attrs) if attrs.is_a? Array
    @ms_options = attrs
  end

  module ClassMethods
  end
end
