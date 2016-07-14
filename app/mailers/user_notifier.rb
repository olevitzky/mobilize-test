class UserNotifier < ActionMailer::Base
  include SendGrid

  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  default :from => 'mobilize-test@example.com'

  # sending the invitation email to the passed users.
  # users must be maximum 999 elements. The rest will not be sent
  def invitation(users)
    # making sure we only send in bulks of 1000 emails by the Sendgrid Api limits
    users = users[0..998]
    sendgrid_recipients users.collect {|user| user.email}
    sendgrid_substitute "|name|", users.collect {|user| user.name}
    mail :to => "dummy@email.com", :subject => "Invitation to a demo app"
  end
end