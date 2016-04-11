module ApplicationHelper
  def title
    raw('<h1>' + @page_title + '</h1>')
  end
end
