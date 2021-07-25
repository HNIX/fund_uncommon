class Rest::BaseWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_webhook_token!

  private

  def authenticate_webhook_token!
    if (user = user_from_token)
      sign_in user, store: false
    else
      head :unauthorized
    end
  end

  def source_from_token
    @source_from_token ||= Source.find_by(webhook_token: params[:webhook_token])
  end

  def user_from_token
    if source_from_token.present?
      source_from_token.touch(:last_used_at)
      source_from_token.user
    end
  end
end