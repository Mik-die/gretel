module Gretel
  module Crumbs
    class << self
      # Lay out the breadcrumbs.
      #
      # Example:
      #   Gretel::Crumbs.layout do
      #     crumb :root do
      #       link "Home", root_path
      #     end
      #   end
      def layout(&block)
        # The URL helpers include needs to be done here because
        # Rails.application isn't set when this file is required
        # TODO: Can this be done otherwise?
        Gretel::Crumb.send :include, Rails.application.routes.url_helpers
        instance_eval &block
      end

      # Stores the supplied block for later use.
      def crumb(key, &block)
        crumbs[key] = block
      end

      # Returns an array of all stored crumb blocks.
      def crumbs
        @crumbs ||= {}
      end
    end
  end
end