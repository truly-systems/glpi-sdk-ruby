require 'spec_helper'

RSpec.describe GLPI::SDK::Resource do
  let(:session) do
    url = 'http://localhost/glpi/apirest.php'
    app_token = 'Vhcc3g5udXBcUEDdtdxOxzBkyK9XwF2aJuiUKPeb'
    username = 'glpi'
    password = 'glpi'

    GLPI::SDK::Session.new(url, app_token, username, password)
  end

  let(:item) do
    GLPI::SDK::Resource.find(session, 1, 'Blacklist')
  end

  context '#create', :vcr do
    it 'should create an item' do
      item = GLPI::SDK::Resource.create(
        session,
        id: 29,
        type: 1,
        name: 'SDK name test',
        value: 'SDK value test',
        item_type: 'Blacklist'
      )

      expect(item.id).not_to be_nil
    end
  end

  context '#update', :vcr do
    it 'should update an item' do
      item = GLPI::SDK::Resource.update(
        session,
        29,
        name: 'SDK name updated',
        item_type: 'Blacklist'
      )

      expect(item.name).to eq 'SDK name updated'
    end
  end

  context '#destroy', :vcr do
    it 'should delete an item by id' do
      expect(GLPI::SDK::Resource.destroy(session, 29, 'Blacklist')).to be true
    end
  end

  context '#find', :vcr do
    it 'should return the attribute value' do
      expect(item.id).to eq 1
    end

    it 'should raise method missing if attribute is not present' do
      expect { item.foo }.to raise_error(NoMethodError)
    end
  end

  context '#all', :vcr do
    it 'should return a list of items' do
      items = GLPI::SDK::Resource.all(session, item_type: 'Blacklist')
      expect(items).not_to be_empty
    end

    it 'should use range parameter to return three results' do
      items = GLPI::SDK::Resource.all(session, range: '1-3', item_type: 'Blacklist')
      expect(items.count).to eq 3
    end

    it 'should return item by name' do
      item = GLPI::SDK::Resource.all(
        session,
        searchText: { name: 'empty MAC' },
        item_type: 'Blacklist'
      ).first

      expect(item.name).to eq 'empty MAC'
    end

    it "should have a 'where' alias method" do
      expect(GLPI::SDK::Resource.method(:where)).to eq(GLPI::SDK::Resource.method(:all))
    end
  end
end
