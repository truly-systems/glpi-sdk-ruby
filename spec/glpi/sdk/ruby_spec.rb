require 'spec_helper'

RSpec.describe Glpi::Sdk::Ruby do
  it 'has a version number' do
    expect(Glpi::Sdk::Ruby::VERSION).not_to be nil
  end
end
