class ApplicationController < ActionController::Base
  include JsonResponseHandler
  protect_from_forgery with: :null_session
end
