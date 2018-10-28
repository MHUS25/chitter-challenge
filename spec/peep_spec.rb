require 'peep'
require 'database_helper'

describe Peep do
  let(:user_class) { double(:user_class) }

  describe '.all' do
    it 'returns all peeps' do

      user = User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')
      peep = Peep.create(message: 'My first peep', peep_timestamp: Time.now, user_id: user.id)
      Peep.create(message: 'Hello', peep_timestamp: Time.now, user_id: user.id)

      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq peep.id
      expect(peeps.first.message).to eq 'My first peep'
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      user = User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')
      peep = Peep.create(message: 'Test Peep', peep_timestamp: Time.now, user_id: user.id)
      persisted_data = persisted_data(table: 'peeps', id: peep.id)

      expect(peep).to be_a Peep
      expect(peep.id).to eq persisted_data.first['id']
      expect(peep.message).to eq 'Test Peep'
    end
  end

  describe '#user' do
    it 'calls .find on the User class' do
      user = User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')
      peep = Peep.create(message: 'Test Peep', peep_timestamp: Time.now, user_id: user.id)
      expect(user_class).to receive(:find).with(peep.user_id)
      peep.user(user_class)
    end
  end
end
