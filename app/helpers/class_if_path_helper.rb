# frozen_string_literal: true

module ClassIfPathHelper
  def class_if_path(class_name, path)
    return class_name if request.original_fullpath&.match?(Regexp.new(path))
  end

  def class_unless_path(class_name, path)
    return class_name unless request.original_fullpath&.match?(Regexp.new(path))
  end
end
