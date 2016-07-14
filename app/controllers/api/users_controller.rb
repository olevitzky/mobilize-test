class Api::UsersController < ActionController::Base
  respond_to :json

  PER_PAGE = 20

  def index
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @users = User.paginate(:page => @page, :per_page => PER_PAGE)
  end

  ## POST
  def upload_contacts
    if params[:file].present?
      uploaded_io = params[:file]
      file_name = "#{Time.now.to_f.to_s.gsub('.', '')}_#{uploaded_io.original_filename}"
      path = Rails.root.join('public', 'uploads', file_name)
      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      # starting the user upload job
      UploadContactsWorker.perform_async(path.to_s)

      render :json => {:message => "We are uploading your users...", :id => file_name}
    else
      render :json => {:message => "error"}, :status => 400
    end
  end

  ## POST
  def invite_all
    InviteAllUsersWorker.perform_async

    render :json => {:message => "Invitation emails are being sent to all of the users"}
  end
end