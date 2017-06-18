module ScreensHelper
  def get_tag_list(category)
    Screen.joins(:tags, :category).where('categories.name = ?', category).pluck(:'tags.name')
  end
end
