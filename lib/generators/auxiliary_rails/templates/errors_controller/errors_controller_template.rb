class ErrorsController < ApplicationController
  DEFAULT_ERROR_STATUS = 500

  def error
    render status: params[:status] || DEFAULT_ERROR_STATUS
  end

  def not_found_error
    render status: 404
  end

  def unacceptable_error
    render status: 422
  end
end
