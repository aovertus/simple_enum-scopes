module SimpleEnum
  module Scope
    module Extension
      def generate_enum_scopes_extension_for enum, accessor
        define_range_scopes(enum, accessor)
        define_multiple_values_scope(enum_accessor)
      end

      private

      def define_range_scope_methods(enum, accessor)
        singleton_class.send(:define_method, "#{accessor.name}_between") do |min_val, max_val|
          where(accessor.source => singleton_class.public_send(min_val)..singleton_class.public_send(max_val))
        end
      end

      def define_multiple_values_scope_method(enum, accessor)
        # arr can be an array of values or a single value
        singleton_class.send(:define_method, "#{accessor.name}_as") do |*arr|
          targeted_values = arr & enum.keys
          where(accessor.source => targeted_values)
        end
      end
    end
  end
end
