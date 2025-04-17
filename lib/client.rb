# frozen_string_literal: true

class Client
  attr_reader :id, :full_name, :email

  def initialize(id:, full_name:, email:)
    @id = id
    @full_name = full_name
    @email = email
  end

  def to_s
    "ID: #{id}, Name: #{full_name}, Email: #{email}"
  end
end
