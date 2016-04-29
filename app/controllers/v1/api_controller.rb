class V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: exception.message }, status: :not_found
  end

  [ActiveRecord::RecordInvalid, ArgumentError, RuntimeError].each do |error|
     rescue_from error do |exception|
       render json: { errors: exception.message }, status: :unprocessable_entity
    end
  end

  rescue_from Twitter::Error::Unauthorized do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from Twitter::Error::TooManyRequests do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from Twitter::Error::BadRequest do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end
end
