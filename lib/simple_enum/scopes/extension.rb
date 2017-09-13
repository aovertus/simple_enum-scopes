module SimpleEnum
  module Scopes
    module Extension
      def generate_enum_scopes_extension_for enum, accessor
        define_range_scope_method(enum, accessor)
        define_multiple_values_scope_method(enum, accessor)
      end

      private

      def define_range_scope_method(enum, accessor)
        singleton_class.send(:define_method, "#{accessor.name}_between") do |min_val, max_val|
          where(accessor.source => enum[min_val]..enum[max_val])
        end
      end

      def define_multiple_values_scope_method(enum, accessor)
        # arr can be an array of values or a single value
        singleton_class.send(:define_method, "#{accessor.name.pluralize}_as") do |arr|
          targeted_values = Array(arr).map(&:to_s) & enum.keys
          where(accessor.source => targeted_values.map{ |value| enum[value] })
        end
      end
    end
  end
end
