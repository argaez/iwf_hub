module Avo
  module Resources
    class ApplicationResource < Avo::BaseResource
      self.model_class = nil

      private

      def admin_visible
        -> { current_user.super_admin? || current_user.admin? }
      end
    end
  end
end