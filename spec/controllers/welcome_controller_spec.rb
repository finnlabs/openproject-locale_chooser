require File.dirname(__FILE__) + '/../spec_helper'

describe WelcomeController, type: :controller do

  before do
    # patch the controller for the test
    @controller.class.send(:include, OpenProject::LocaleChooser::ControllerPatch) unless @controller.class.included_modules.include?(OpenProject::LocaleChooser::ControllerPatch)
  end

  describe :index do
    describe 'WITH a locale specified in the session' do
      before do
        allow(Setting).to receive(:available_languages).and_return([:en, :de])

        session[:locale] = 'de'

        get :index
      end

      it { expect(::I18n.locale).to eq(:de) }
    end
  end

  after do
    ::I18n.locale = :en
  end
end
