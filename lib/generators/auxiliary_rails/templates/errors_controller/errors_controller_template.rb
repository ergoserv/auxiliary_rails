class ErrorsController < ApplicationController
  DEFAULT_ERROR_STATUS = 500

  def show
    render status: params[:status] || DEFAULT_ERROR_STATUS
  end

  def not_found
    render status: :not_found
  end

  def unacceptable
    render status: :unprocessable_entity
  end
end
