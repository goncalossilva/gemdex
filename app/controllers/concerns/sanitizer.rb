module Sanitizer
  extend ActiveSupport::Concern

  def sanitized(hash)
    puts hash
    result = {}
    hash.each do |k,v|
      result[k] = v.downcase.strip! || v.downcase
    end
    puts result
    return result
  end
end