# frozen_string_literal: true

class UsersSearch
  include Interactor

  before do
    @query = context.params[:search].presence || '*'
    @filters = context.params.except(:search, :page)
    @current_user_id = context.current_user.id
  end

  def call
    context.users = search_users
  end

  private

  def search_users
    User.search(
      @query,
      where:,
      load: true,
      page: context.params[:page] || 1,
      per_page: 100
    )
  end

  def where
    {
      status: :active,
      age: age_range,
      gender:,
      id: { not: liked_user_ids }
    }
  end

  def liked_user_ids
    Like.where(
      user_id: @current_user_id,
      likeable_type: 'User'
    ).pluck(:likeable_id)
  end

  def age_range
    (@filters[:min_age]..@filters[:max_age])
  end

  def gender
    @filters[:gender] || %i[male female]
  end
end
