class PayOSError < StandardError
  attr_reader :code

  def initialize(code:, message:)
    @code = code
    super(message)
  end
end
