require "slim"
require "dry-view"

require "main/container"
require "main/page"

require "high_spirits/assets"

module Main
  Container.register "page", Page.new(assets: HighSpirits::Assets.new)

  class View < Dry::View::Layout
    setting :root, Container.root.join("web/templates")
    setting :scope, Container["page"]
    setting :formats, {html: :slim}
    setting :name, "application"

    def locals(options)
      super.merge(options[:scope].view_locals)
    end
  end
end
