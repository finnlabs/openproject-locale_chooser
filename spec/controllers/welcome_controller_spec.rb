require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

describe WelcomeController do

  before do
    # patch the controller for the test
    @controller.class.send(:include, LocaleChooser::ControllerPatch)
  end

  describe :index do
    describe "WITH a locale specified in the session" do
      before do
        Setting.available_languages = [:en, :de]

        session[:locale] = "de"

        get :index
      end

      it { ::I18n.locale.should == :de }
    end
  end

  after do
    ::I18n.locale = :en
  end
end
