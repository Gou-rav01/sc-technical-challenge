# frozen_string_literal: true

require 'spec_helper'

describe Client do
  let(:client) { described_class.new(id: 1, full_name: 'John Doe', email: 'john.doe@gmail.com') }

  describe '#initialize' do
    it 'sets id' do
      expect(client.id).to eq(1)
    end

    it 'sets full_name' do
      expect(client.full_name).to eq('John Doe')
    end

    it 'sets email' do
      expect(client.email).to eq('john.doe@gmail.com')
    end

    it 'handles empty full_name' do
      client = described_class.new(id: 2, full_name: '', email: '')
      expect(client.full_name).to eq('')
    end

    it 'handles empty email' do
      client = described_class.new(id: 2, full_name: '', email: '')
      expect(client.email).to eq('')
    end
  end

  describe '#to_s' do
    it 'returns a formatted string representation' do
      expect(client.to_s).to eq('ID: 1, Name: John Doe, Email: john.doe@gmail.com')
    end

    it 'handles empty full_name and email in string representation' do
      client = described_class.new(id: 3, full_name: '', email: '')
      expect(client.to_s).to eq('ID: 3, Name: , Email: ')
    end
  end
end
