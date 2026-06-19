module Avo
  class HomeController < ApplicationController
    def index
      if Avo.configuration.home_path.present?
        computed_path = if Avo.configuration.home_path.respond_to? :call
          instance_exec(&Avo.configuration.home_path)
        else
          Avo.configuration.home_path
        end
        redirect_to computed_path
      end
      # Sin redirect — renderiza app/views/avo/home/index.html.erb
    end
  end
end