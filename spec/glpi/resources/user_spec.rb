require 'spec_helper'

RSpec.describe GLPI::SDK::User do
  let(:session) do
    url = 'http://localhost/glpi/apirest.php'
    app_token = 'Vhcc3g5udXBcUEDdtdxOxzBkyK9XwF2aJuiUKPeb'
    username = 'glpi'
    password = 'glpi'

    GLPI::SDK::Session.new(url, app_token, username, password)
  end

  let(:user) do
    GLPI::SDK::User.find(session, 2)
  end

  context '#create', :vcr do
    it 'should create an user' do
      created_user = GLPI::SDK::User.create(
        session,
        id: 29,
        name: 'foo',
        realname: 'Bar',
        firstname: 'Foo'
      )

      expect(created_user.id).not_to be_nil
    end
  end

  context '#update', :vcr do
    it 'should update an user' do
      updated_user = GLPI::SDK::User.update(
        session,
        29,
        firstname: 'Baz'
      )

      expect(updated_user.firstname).to eq 'Baz'
    end
  end

  context '#destroy', :vcr do
    it 'should delete an user by id' do
      expect(GLPI::SDK::User.destroy(session, 29)).to be true
    end
  end

  context '#find', :vcr do
    it 'should return an user instance identified by id' do
      expect(user).to be_instance_of(GLPI::SDK::User)
    end

    it 'should return the attribute value' do
      expect(user.id).to eq 2
    end

    it 'should raise method missing if attribute is not present' do
      expect { user.foo }.to raise_error(NoMethodError)
    end
  end

  context '#all', :vcr do
    it 'should return a list of users' do
      users = GLPI::SDK::User.all(session)
      users.take(2).each { |user| expect(user).to be_instance_of(GLPI::SDK::User) }
    end

    it 'should use range parameter to return three results' do
      users = GLPI::SDK::User.all(session, range: '1-3')
      expect(users.count).to eq 3
    end

    it 'should return user by name' do
      user = GLPI::SDK::User.all(session, searchText: { name: 'tech' }).first
      expect(user.name).to eq 'tech'
    end

    it "should have a 'where' alias method" do
      expect(GLPI::SDK::User.method(:where)).to eq(GLPI::SDK::User.method(:all))
    end
  end
end
