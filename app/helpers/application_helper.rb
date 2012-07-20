module ApplicationHelper

  def controller?(controller)
    params[:controller] == controller.to_s
  end

end
