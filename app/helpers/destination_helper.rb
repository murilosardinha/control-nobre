# frozen_string_literal: true

module DestinationHelper
  def color_enum_generator(status)
    case status
    when "active"
      content_tag(:span, "ativo", class: "badge badge-success")
    when "inactive"
      content_tag(:span, "inativo", class: "badge badge-light")
    end
  end
end
