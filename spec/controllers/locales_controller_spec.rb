require File.dirname(__FILE__) + '/../spec_helper'

describe LocalesController, type: :controller do

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
    let(:params) { { 'locale' => locale } }
    let(:action) { put :update, params }
    let(:active_locale) { 'en' }

    before do
      allow(Setting).to receive(:available_languages).and_return([active_locale])
    end

    describe 'WITH an active language' do
      let(:locale) { active_locale }

      before do
        action
      end

      it { expect(session[:locale]).to eq(locale) }
    end

    describe 'WITH a non active/unknown language' do
      let(:locale) { 'wk' }

      before do
        action
      end

      it { expect(session[:locale]).to be_nil }
    end

    describe 'WITH a back_url' do
      let(:back_url) { work_packages_url }
      let(:locale) { active_locale }

      before do
        params[:back_url] = work_packages_url

        action
      end

      it { expect(response).to redirect_to work_packages_url }
    end
  end
end
