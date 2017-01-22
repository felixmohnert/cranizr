class CreateRPackages < ActiveRecord::Migration[5.0]
  def change
    create_table :r_packages do |t|
      t.string :name
      t.string :version
      t.text :depends
      t.text :suggests
      t.string :license
      t.timestamp :version_date
      t.text :long_name
      t.text :authors
      t.string :maintainer_name
      t.string :maintainer_email
      t.text :description
      t.string :repository
      t.timestamp :packaged_at
      t.string :packaged_by
      t.timestamp :publication_at

      t.timestamps
    end
  end
end
