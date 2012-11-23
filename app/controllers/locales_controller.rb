class LocalesController < ApplicationController
  unloadable

  skip_before_filter :check_if_login_required

  include LocaleChooser::Manual

  def update
    set_manual_locale(params[:locale])
    redirect_to back_url
  end

  private

  def back_url
    params[:back_url].present? ?
      CGI::unescape(params[:back_url]) :
      home_url
  end
end
