class AddNcmToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :ncm, :string
  end
end
