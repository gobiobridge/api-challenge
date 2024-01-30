class ApiError < StandardError
  attr_reader :status, :message

  def initialize(message:, status: 400)
    super(message)

    @status = status
    @message = message
  end
end
