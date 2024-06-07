class CreateJoinTableCompaniesUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :companies, :users, table_name: :companies_users do |t|
      t.index [:user_id, :company_id], name: 'index_companies_users_on_user'
      t.index [:company_id, :user_id], name: 'index_companies_users_on_companies'
    end
  end
end
