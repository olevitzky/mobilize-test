object false

node :total_results do
  @users.try(:total_entries).to_i
end

node :pagination do
  {:current_page => @page, :total_pages => @users.try(:total_pages).to_i}
end

child @users, :root => "users", :object_root => false do |user|
  node false do |user|
    partial("api/users/user_details", :object => user)
  end
end