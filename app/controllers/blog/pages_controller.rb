class Blog::PagesController < ApplicationController
  include Cms::BaseFilter
  include Cms::PageFilter
  include Workflow::PageFilter

  model Blog::Page

  append_view_path "app/views/cms/pages"
  navi_view "blog/main/navi"

  private
    def fix_params
      { cur_user: @cur_user, cur_site: @cur_site, cur_node: @cur_node }
    end

  #public
    # Cms::PageFilter
end
