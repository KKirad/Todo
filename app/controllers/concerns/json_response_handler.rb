module JsonResponseHandler
  extend ActiveSupport::Concern

  def success(object, meta = {})
    {
      status: 'success',
      "#{get_class_name(object)}": object.as_json
    }.merge(meta)
  end

  def error(object)
    {
      status: 'error',
      message: "Validation errors for #{get_class_name(object)}",
      errors: serialize(object.errors)
    }
  end

  def get_class_name(object)
    if object.try(:base_class).nil?
      object.class.name.underscore
    else
      object.base_class.name.underscore.pluralize
    end
  end

  def serialize(errors)
    return if errors.nil?
    json = {}
    errors.to_hash(true).map do |k, v|
      v.map do |msg|
        json[k] = msg
      end
    end
    json
  end
end
