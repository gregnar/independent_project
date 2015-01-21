class SessionsController < ApplicationController

  def new
    redirect_to '/auth/goodreads'
  end

  def create
    @user = User.where(goodreads_id: auth_hash_user_id).first || User.create(goodreads_id: auth_hash_user_id)
    reset_session
    session[:user_id] = @user.id
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_hash_user_id
    auth_hash['uid']
  end

  def access_token_key
    auth_hash['extra']['access_token']['token']
  end

  def access_token_secret
    auth_hash['extra']['access_token']['secret']
  end

end
