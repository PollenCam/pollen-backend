require 'rails_helper'

RSpec.describe Membership, type: :model do
  before(:all) { @membership = Membership.new }

  %w{ user event role }.each do |attribute|
    it("Responds to ##{attribute}") { @membership.send(attribute) }
  end
end
