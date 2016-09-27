class PagesController < ApplicationController
  def home
    @airports = Airport.select(:id, :name)
  end

  def about
  end

  def contact
  end
end
