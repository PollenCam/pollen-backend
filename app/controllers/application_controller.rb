class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include EnsureJson
end
