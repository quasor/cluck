# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def admin?
	controller.admin?
  end
  def current_user
	controller.current_user
  end
end
