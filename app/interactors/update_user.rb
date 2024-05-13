class UpdateUser
  include Interactor

  before do
    context.user = User.find(context.params[:id])
  rescue ActiveRecord::RecordNotFound => e
    context.fail!(message: e)
  end

  def call
    context.user.update(context.params)
  end
end
