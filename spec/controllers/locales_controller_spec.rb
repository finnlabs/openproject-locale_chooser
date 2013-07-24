require File.dirname(__FILE__) + '/../spec_helper'

describe LocalesController do

  # #Beginnin with rails 3.2 there is a :null_store for effectively disabling caching in test environment
  def clear_settings_cache
    Rails.cache.clear
  end

  # this is the base method for get, post, etc.
  def process(*args)
    clear_settings_cache
    result = super
    clear_settings_cache
    result
  end

  describe :put do
    let(:params) { { "locale" => locale } }
    let(:action) { put :update, params }
    let(:active_locale) { "en" }

    before do
      Setting.available_languages = [active_locale]
    end

    describe "WITH an active language" do
      let(:locale) { active_locale }

      before do
        action
      end

      it { session[:locale].should == locale }
    end

    describe "WITH a non active/unknown language" do
      let(:locale) { "wk" }

      before do
        action
      end

      it { session[:locale].should be_nil }
    end

    describe "WITH a back_url" do
      let(:back_url) { issues_url }
      let(:locale) { active_locale }

      before do
        params[:back_url] = issues_url

        action
      end

      it { response.should redirect_to issues_url }
    end
  end
end
