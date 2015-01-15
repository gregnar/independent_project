class SessionsController < ApplicationController

  def new
    redirect_to '/auth/goodreads'
  end

  def create
    @user = User.where(provider: auth_hash['provider'],
                       uid: auth_hasn['uid'].to_s).first || User.create(auth_hash)
    reset_session
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Signed in!'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
