# Copyright 2016 Team 254. All Rights Reserved.
# @author pat@patfairbank.com (Patrick Fairbank)
#
# Encrypts and decrypts data using a shared secret.

require "aescrypt"
require "base64"

module CheesyCommon
  module Crypto
    class NoSecretError < StandardError; end

    def self.secret
      return ENV["TEAM254_SECRET"] if ENV.has_key?("TEAM254_SECRET")
      raise NoSecretError.new("TEAM254_SECRET environment variable not set.")
    end

    def self.encrypt(data)
      AESCrypt.encrypt(data, secret)
    end

    def self.decrypt(data)
      AESCrypt.decrypt(data, secret)
    end
  end
end
