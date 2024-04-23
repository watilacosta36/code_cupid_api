class User::CreateAccount
  include Interactor

  def call
    user = User.new(context.params)

    context.user = user if user.save!
  rescue ActiveRecord::RecordInvalid => error
    context.fail!(error: error.message)
  end
end
