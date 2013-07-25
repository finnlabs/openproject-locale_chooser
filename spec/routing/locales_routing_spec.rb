describe LocalesController do
  describe 'routing' do
    it { put('/my/locale').should route_to(:controller => 'locales', :action => 'update')}
  end
end
