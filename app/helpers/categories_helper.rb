module CategoriesHelper
  def current_category
    @current_category ||= nil
  end

  def link_to_category(category, restaurant, current=nil)
    css_class = "category"
    if category == current
      css_class += " active"
    end

    link_to category.title,
            menu_items_path(restaurant, category.to_param),
            class: css_class
  end
end

