require 'active_record'
# require 'mongoid'

module ModelSupport
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def fake_active_record(name, &block)
      let(name) {
        Class.new(ActiveRecord::Base) do
          self.table_name = 'dummies'
          instance_eval &block
        end
      }
    end
  end
end
