class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


    private
  
  def current_room
  	# ||= for cachind
    @room ||= Room.find(session[:current_room]) if session[:current_room]
  end
  
  helper_method :current_room # should be a helper method inorder to be able to call it from the views
end
