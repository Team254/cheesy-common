# Copyright 2016 Team 254. All Rights Reserved.
# @author pat@patfairbank.com (Patrick Fairbank)
#
# Model representing a logged-in user.

module CheesyCommon
  class User
    class NoFieldError < StandardError; end

    def initialize(fields)
      @fields = fields
    end

    def has_permission?(permission)
      permissions.include?(permission)
    end

    def method_missing(method)
      raise NoFieldError.new("No such field: #{method}") unless @fields.has_key?(method.to_s)
      @fields[method.to_s]
    end
  end
end
