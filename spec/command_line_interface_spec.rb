# frozen_string_literal: true

require 'spec_helper'

describe CommandLineInterface do
  let(:client_model) { instance_double(ClientModel) }
  let(:cli) { described_class.new(client_model:) }

  describe '#initialize' do
    it 'sets the client_model' do
      expect(cli.instance_variable_get(:@client_model)).to eq(client_model)
    end
  end

  describe '#handle_choice' do
    it 'calls search_clients for choice 1' do
      allow(cli).to receive(:search_clients)
      cli.send(:handle_choice, choice: '1')
      expect(cli).to have_received(:search_clients)
    end

    it 'calls find_duplicates for choice 2' do
      allow(cli).to receive(:find_duplicates)
      cli.send(:handle_choice, choice: '2')
      expect(cli).to have_received(:find_duplicates)
    end

    it 'prints error message for invalid choice' do
      expect { cli.send(:handle_choice, choice: '4') }
        .to output(/Invalid choice. Please try again./).to_stdout
    end
  end

  describe '#display_results' do
    let(:clients) { [instance_double(Client, to_s: 'ID: 1, Name: John Doe, Email: john.doe@gmail.com')] }

    it 'displays results when clients are found' do
      expect { cli.send(:display_results, results: clients, message: 'Search results') }
        .to output(/Search results\nID: 1, Name: John Doe, Email: john.doe@gmail.com\n\n/).to_stdout
    end

    it 'displays no clients found message when empty' do
      expect { cli.send(:display_results, results: [], message: 'Search results') }
        .to output(/Search results\nNo clients found.\n\n/).to_stdout
    end
  end
end
