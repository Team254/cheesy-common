# Copyright 2016 Team 254. All Rights Reserved.
# @author pat@patfairbank.com (Patrick Fairbank)
#
# Parses and decodes configs for the current environment.

require "json"

module CheesyCommon
  module Config
    class NoValueFoundError < StandardError; end

    def self.environment
      ENV["TEAM254_ENV"] || "dev"
    end

    def self.all_configs
      @@all_configs ||= JSON.parse(File.read("config.json"))
    end

    def self.env_configs
      @@env_configs ||= {}
    end

    def self.decode_param(param)
      if param.is_a?(String) && param.start_with?("Encrypted:")
        Crypto.decrypt(param[10..-1])
      else
        param
      end
    end

    def self.method_missing(method)
      key = method.to_s
      return env_configs[key] if env_configs.has_key?(key)

      # Look in environment-specific configs first, then global configs.
      [environment, "global"].each do |env|
        if all_configs[env].has_key?(key)
          env_configs[key] = decode_param(all_configs[env][key])
          return env_configs[key]
        end
      end

      raise NoValueFoundError.new("No value found for config param '#{key}'.")
    end
  end
end
