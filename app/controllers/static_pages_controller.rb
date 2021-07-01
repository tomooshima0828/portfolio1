class StaticPagesController < ApplicationController
  def top
  end

  def menus_overview
    @menus = Menu.all
  end

  def staff
  end

  def inquiry
  end
end
