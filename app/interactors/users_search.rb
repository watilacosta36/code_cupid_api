# frozen_string_literal: true

class UsersSearch
  include Interactor

  before do
    @query = context.params[:search].presence || '*'
    @filters = context.params.except(:search, :page)
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
      page: context.params[:page],
      per_page: 100
    )
  end

  def where
    {
      status: :active,
      age: @filters[:age],
      gender: @filters[:gender]
    }
  end
end
