require_relative './database_connection'
require 'uri'

class Peep

  attr_reader :id, :message, :peep_timestamp, :user_id

  def initialize(id:, message:, peep_timestamp:, user_id:)
    @id = id
    @message = message
    @peep_timestamp = peep_timestamp
    @user_id = user_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM peeps")
    result.map do |peep|
      Peep.new(id: peep['id'], message: peep['message'], peep_timestamp: peep['peep_timestamp'], user_id: peep['user_id'])
    end
  end

  def self.create(message:, peep_timestamp:, user_id:)
    result = DatabaseConnection.query("INSERT INTO peeps (message, peep_timestamp, user_id) VALUES('#{message}', '#{peep_timestamp.strftime("%Y-%m-%d %k:%M")}', '#{user_id}') RETURNING id, message, peep_timestamp, user_id;")
    Peep.new(id: result[0]['id'], message: result[0]['message'], peep_timestamp: result[0]['peep_timestamp'], user_id: result[0]['user_id'])
  end

  def user(user_class = User)
    user_class.find(@user_id)
  end

end
