class PagesController < ApplicationController
  def home
    @airports = Airport.select(:id, :name)
  end
end
