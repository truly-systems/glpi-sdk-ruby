require 'spec_helper'

RSpec.describe GLPI::SDK do
  it 'has a version number' do
    expect(GLPI::SDK::VERSION).not_to be nil
  end
end
