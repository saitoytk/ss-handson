class Blog::Page
  include Cms::Model::Page
  include Cms::Addon::Meta
  include Cms::Addon::Body
  include Cms::Addon::File
  include Blog::Addon::Weather
  include Cms::Addon::Release
  include Cms::Addon::ReleasePlan
  include Cms::Addon::RelatedPage
  include Category::Addon::Category
  include Workflow::Addon::Approver

  before_save :seq_filename, if: ->{ basename.blank? }

  default_scope ->{ where(route: "blog/page") }

  private
    def validate_filename
      (@basename && @basename.blank?) ? nil : super
    end

    def seq_filename
      self.filename = dirname ? "#{dirname}#{id}.html" : "#{id}.html"
    end
end
