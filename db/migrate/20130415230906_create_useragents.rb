class CreateUseragents < ActiveRecord::Migration
  def change
    create_table :useragents do |t|
      t.column :useragent, :text
      t.column :last_accessed, :datetime
    end
  end
end
