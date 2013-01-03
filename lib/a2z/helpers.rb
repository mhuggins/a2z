module A2z
  module Helpers
    def self.included(base)
      base.extend(self)
    end
    
    protected
    
    def underscore(camel_cased_word)
      camel_cased_word.dup.tap do |word|
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        word.tr!('-', '_')
        word.downcase!
      end
    end
    
    def array_wrap(value)
      value.kind_of?(Array) ? value : [value].compact
    end
  end
end
