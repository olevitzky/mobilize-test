require 'rubyXL'

class UploadContactsWorker
  include Sidekiq::Worker

  def perform(path_to_file)
    workbook = RubyXL::Parser.parse(path_to_file)
    sheet = workbook.worksheets[0]

    row_index = 1
    row = sheet[row_index]
    while (not row.nil?)
      begin
        name = row[0].value
        email = row[1].value
        user = User.new(:name => name, :email => email)
        if user.save
          p "#{name}, #{email} was added successfully" 
        else
          p "there was a problem adding user data: name: #{name}, email: #{email}. The reason is: #{user.errors.full_messages.join(", ")}"
        end
      rescue Exception => e
      end

      row_index += 1
      row = sheet[row_index]
    end

    # delete file
    File.delete(path_to_file)
  end
end