class SessionsController < ApplicationController

  def new
    redirect_to '/auth/goodreads'
  end

  def create
    @user = User.where(goodreads_id: auth_hash_user_id).first || User.create(goodreads_id: auth_hash_user_id)
    @user.set_access_token(access_token_key, access_token_secret)
    reset_session
    session[:user_id] = @user.id
    redirect_to dashboard_index_path
  end

  def destroy
    current_user.access_token.destroy
    session[:user_id] = nil
    redirect_to root_path
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
