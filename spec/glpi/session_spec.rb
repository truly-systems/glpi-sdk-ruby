require 'spec_helper'

RSpec.describe GLPI::SDK::Session do
  let(:session) do
    url = 'http://localhost/glpi/apirest.php'
    app_token = 'Vhcc3g5udXBcUEDdtdxOxzBkyK9XwF2aJuiUKPeb'
    username = 'glpi'
    password = 'glpi'

    GLPI::SDK::Session.new(url, app_token, username, password)
  end

  context '#initialize', :vcr do
    it 'stores the session token on token variable' do
      expect(session.token).not_to be_nil
    end
  end

  context '#init', :vcr do
    it 'returns a session token' do
      token = session.init
      expect(token).not_to be_nil
    end

    it 'stores the session token on token variable' do
      session.init
      expect(session.token).not_to be_nil
    end
  end

  context '#kill', :vcr do
    it 'token variable should be nil' do
      session.init
      session.kill

      expect(session.token).to be_nil
    end
  end
end
