require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

describe LocalesController do
  describe :routes do
    it { params_from(:put, "/my/locale").should == { :controller => "locales",
                                                     :action => "update" } }
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
