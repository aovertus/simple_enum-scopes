module ActiveRecordSupport
  def self.connection
    @connection_pool ||= ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
    ActiveRecord::Base.connection
  end

  def self.included(base)
    base.before(:each) { self.reset_active_record }
  end

  def reset_active_record
    ActiveRecordSupport.connection.create_table :dummies, :force => true do |t|
      t.column :state_cd, :integer
    end
  end
end

# Behave like the railtie.rb
ActiveRecord::Base.send :extend, SimpleEnum::Attribute
