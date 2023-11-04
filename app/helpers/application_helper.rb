module ApplicationHelper
  def header_link_class_names(path)
    class_names(
      'text-decoration-none',
      'text-primary' => current_page?(path),
      'text-body' => !current_page?(path)
    )
  end
end
