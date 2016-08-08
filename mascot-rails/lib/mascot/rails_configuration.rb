module Mascot
  # Configuration object for rails application.
  class RailsConfiguration
    # Store in ./app/pages by default.
    DEFAULT_SITE_ROOT = "app/pages".freeze

    attr_accessor :site, :resources, :parent_engine, :routes, :cache_resources, :partials

    # Set defaults.
    def initialize
      @routes = true
      @parent_engine = Rails.application
      @cache_resources = @parent_engine.config.cache_classes
      @partials = false
    end

    def site
      @site ||= Site.new(root: default_root).tap do |site|
        site.resources_pipeline << Extensions::PartialsRemover.new unless partials
        site.resources_pipeline << Extensions::RailsRequestPaths.new
      end
    end

    def resources
      # Production will cache resources globally. This drastically speeds up
      # the speed at which resources are served, but if they change it won't be updated.
      @resources = nil unless cache_resources?
      @resources ||= site.resources
    end

    def cache_resources?
      !!@cache_resources
    end

    private
    def default_root
      Rails.root.join(DEFAULT_SITE_ROOT)
    end
  end
end
