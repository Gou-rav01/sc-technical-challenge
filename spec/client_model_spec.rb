# frozen_string_literal: true

require 'spec_helper'

describe ClientModel do
  let(:client_model) { described_class.new(data:) }
  let(:data) do
    [
      { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john.doe@gmail.com' },
      { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane.smith@yahoo.com' },
      { 'id' => 3, 'full_name' => 'Another Jane Smith', 'email' => 'jane.smith@yahoo.com' },
    ]
  end

  describe '#initialize' do
    it 'creates Client objects with correct size' do
      clients = client_model.instance_variable_get(:@clients)
      expect(clients.size).to eq(3)
    end

    it 'creates Client objects of correct type' do
      clients = client_model.instance_variable_get(:@clients)
      expect(clients.first).to be_a(Client)
    end

    it 'sets correct id for first client' do
      clients = client_model.instance_variable_get(:@clients)
      expect(clients.first.id).to eq(1)
    end

    it 'handles empty data array' do
      client_model = described_class.new(data: [])
      expect(client_model.instance_variable_get(:@clients)).to be_empty
    end

    it 'raises error for missing required keys' do
      invalid_data = [{ 'id' => 1, 'full_name' => 'John Doe' }]
      expect { described_class.new(data: invalid_data) }.to raise_error(KeyError, /Missing required keys: email/)
    end
  end

  describe '#validate_keys' do
    let(:valid_data) { { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john.doe@gmail.com' } }
    let(:invalid_data) { { 'id' => 1, 'full_name' => 'John Doe' } }
    let(:empty_data) { {} }

    it 'does not raise error for valid data' do
      expect { client_model.send(:validate_keys, valid_data) }.not_to raise_error
    end

    it 'raises KeyError for missing required keys' do
      expect { client_model.send(:validate_keys, invalid_data) }
        .to raise_error(KeyError, 'Missing required keys: email')
    end

    it 'raises KeyError for empty data' do
      expect { client_model.send(:validate_keys, empty_data) }
        .to raise_error(KeyError, 'Missing required keys: id, full_name, email')
    end
  end

  describe '#search_by_name' do
    it 'returns correct number of clients with partial name match' do
      results = client_model.search_by_name(query: 'jane')
      expect(results.size).to eq(2)
    end

    it 'returns clients with correct names' do
      results = client_model.search_by_name(query: 'jane')
      expect(results.map(&:full_name)).to include('Jane Smith', 'Another Jane Smith')
    end

    it 'returns all clients for empty query' do
      results = client_model.search_by_name(query: '')
      expect(results.size).to eq(3)
    end

    it 'returns empty array for no matches' do
      results = client_model.search_by_name(query: 'xyz')
      expect(results).to be_empty
    end

    it 'handles case-sensitive queries correctly' do
      results = client_model.search_by_name(query: 'JANE')
      expect(results.size).to eq(2)
    end
  end

  describe '#find_duplicate_emails' do
    it 'returns correct duplicate email keys' do
      duplicates = client_model.find_duplicate_emails
      expect(duplicates.keys).to include('jane.smith@yahoo.com')
    end

    it 'returns correct number of clients for duplicate email' do
      duplicates = client_model.find_duplicate_emails
      expect(duplicates['jane.smith@yahoo.com'].size).to eq(2)
    end

    it 'returns empty hash for no duplicates' do
      single_email_data = [
        { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john.doe@gmail.com' },
      ]
      client_model = described_class.new(data: single_email_data)
      expect(client_model.find_duplicate_emails).to be_empty
    end

    it 'returns empty hash for empty data' do
      client_model = described_class.new(data: [])
      expect(client_model.find_duplicate_emails).to be_empty
    end
  end
end
