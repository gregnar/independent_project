class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :basic_goodreads_client,
                :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def basic_goodreads_client
    @basic_goodreads_client ||= Goodreads.new
  end

  def require_current_user
    unless current_user
      redirect_to root_path, notice: "Login with GoodReads in order to view dashboard."
    end
  end

end
