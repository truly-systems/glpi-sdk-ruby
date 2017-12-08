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

  context '#active_profile', :vcr do
    it 'should return the active profile hash' do
      profile_name = session.active_profile['active_profile']['name']
      expect(profile_name).to eq 'Super-Admin'
    end
  end

  context '#active_entities', :vcr do
    it 'should return the active entity' do
      expect(session.active_entities['active_entity']['id']).to eq 0
    end
  end

  context '#full_session', :vcr do
    it 'should return the full session hash' do
      expect(session.full_session).not_to be_empty
    end
  end

  context '#glpi_config', :vcr do
    it 'should return the glpi config hash' do
      expect(session.glpi_config).not_to be_empty
    end
  end
end
