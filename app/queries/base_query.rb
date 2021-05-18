class BaseQuery
  class << self
    delegate :call, to: :new
  end
end
