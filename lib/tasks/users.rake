task :clear_users => :environment do
  User.delete_all
end