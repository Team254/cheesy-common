# Copyright 2016 Team 254. All Rights Reserved.
# @author pat@patfairbank.com (Patrick Fairbank)
#
# Communicates with the Team 254 single sign-on API to get auth information.

require "httparty"
require "json"

module CheesyCommon
  module Auth
    def self.get_user(request)
      cookie = request.cookies["poof"]
      return nil if cookie.nil?

      response = HTTParty.get("#{Config.members_url}/api/validate/#{cookie}")
      return nil if response.code != 200
      User.new(JSON.parse(Crypto.decrypt(response.body)))
    end

    def self.find_users_with_permission(permission)
      response = HTTParty.get("#{Config.members_url}/api/users?permission=#{permission}")
      return nil if response.code != 200
      JSON.parse(Crypto.decrypt(response.body)).map { |fields| User.new(fields) }
    end
  end
end
