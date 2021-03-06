class UpdateDatabaseJob
  include SuckerPunch::Job

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)
      user.update_followees
      user.update_ratings_and_books
      user.update_suggested_followees
    end
  end
end
