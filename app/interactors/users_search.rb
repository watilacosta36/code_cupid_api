# frozen_string_literal: true

class UsersSearch
  include Interactor

  before do
    @query = context.params[:search].presence || '*'
    @filters = context.params.except(:search)
  end

  def call
    context.users = User.search(@query, where:, load: false)
  end

  private

  def where
    {
      status: :active,
      age: @filters[:age],
      gender: @filters[:gender]
    }
  end
end
