describe LocalesController, type: :routing do
  describe 'routing' do
    it { expect(put('/my/locale')).to route_to(controller: 'locales', action: 'update') }
  end
end
