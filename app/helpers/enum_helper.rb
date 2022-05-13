# frozen_string_literal: true

module EnumHelper
  def t_enum(inst, enum)
    value = inst.send(enum)
    t_enum_class(inst.class, enum, value)
  end

  def t_enum_class(klass, enum, value)
    return if value.blank?

    I18n.t("activerecord.attributes.#{klass.to_s.demodulize.underscore}.#{enum}.#{value}")
  end

  def t_enum_collection(inst, enum)
    inst_class = inst.is_a?(Class) ? inst : inst.class

    inst_class.send(enum.to_s.pluralize).map do |key, _|
      [t_enum_class(inst_class, enum, key), key]
    end
  end

  def t_enum_value_collection(inst, enum)
    inst_class = inst.is_a?(Class) ? inst : inst.class

    inst_class.send(enum.to_s.pluralize).map do |key, value|
      [t_enum_class(inst_class, enum, key), value]
    end
  end

  def color_span_generator(category)
    case category
    when "item"
      content_tag(:span, "Produto", class: "badge badge-success")
    when "epi"
      content_tag(:span, "EPI", class: "badge badge-info")
    end
  end
end
