# frozen_string_literal: true

class CommandLineInterface
  def initialize(client_model:)
    @client_model = client_model
  end

  def start
    loop do
      display_menu
      choice = gets.chomp
      break if choice == '3'

      handle_choice(choice:)
    end
  end

  private

  def display_menu
    puts "\nClient Management System"
    puts '1. Wants to search clients by name'
    puts '2. Wants to Find duplicate emails'
    puts '3. Exit'
    print 'Enter your choice (1-3): '
  end

  def handle_choice(choice:)
    case choice
    when '1'
      search_clients
    when '2'
      find_duplicates
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  def search_clients
    print 'Enter name to search: '
    query = gets.chomp
    results = @client_model.search_by_name(query:)
    display_results(results:, message: "Search results for '#{query}':")
  end

  def find_duplicates
    duplicates = @client_model.find_duplicate_emails
    if duplicates.empty?
      puts 'No duplicate emails found.'
    else
      puts 'Duplicate emails found:'
      duplicates.each do |email, clients|
        puts "\nEmail: #{email}"
        clients.each { |client| puts "  #{client}" }
      end
    end
  end

  def display_results(results:, message:)
    puts "\n#{message}"
    if results.empty?
      puts 'No clients found.'
    else
      results.each { |client| puts client }
    end
    2.times { puts '' }
  end
end
