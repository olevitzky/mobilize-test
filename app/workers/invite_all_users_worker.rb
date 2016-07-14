require 'rubyXL'

class InviteAllUsersWorker
  include Sidekiq::Worker

  def perform
    User.all.each_slice(999) do |users_group|
      UserNotifier.invitation(users_group).deliver_now
    end
  end
end