class HomepageController < ApplicationController
    before_action :require_logged_in_user!

    def index
        render 'index'
    end
end
