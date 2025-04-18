# frozen_string_literal: true

class ClientModel
  REQUIRED_KEYS = %w[id full_name email].freeze

  def initialize(data:)
    @clients = data.map do |client_data|
      validate_keys(client_data)
      Client.new(id: client_data['id'], full_name: client_data['full_name'], email: client_data['email'])
    end
  end

  def search_by_name(query:)
    @clients.select { |client| client.full_name.downcase.include?(query.downcase) }
  end

  def find_duplicate_emails
    email_groups = @clients.group_by { |client| client.email.downcase }
    email_groups.select { |_, clients| clients.length > 1 }
  end

  private

  def validate_keys(client_data)
    missing_keys = REQUIRED_KEYS.reject { |key| client_data.key?(key) }
    raise KeyError, "Missing required keys: #{missing_keys.join(', ')}" unless missing_keys.empty?
  end
end
