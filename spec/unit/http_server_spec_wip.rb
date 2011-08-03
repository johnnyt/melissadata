require 'spec_helper'
require 'melissa-data/http_server'

module MelissaData
  describe HttpServer do

    describe "get a version" do

      it "returns a melissa data object build number" do
        # when
        response = RestClient.get "http://127.0.0.1:23456/version"
        # expect
        response.to_s.should match(/email/i)
      end
    end

    it "returns JSON" do
        # when
        response = RestClient.get "http://127.0.0.1:23456/version"
        # expect
        response.headers[:content_type].should match(/json/)
    end

    describe "processing an email" do

      it "returns a json object with 'email' as top level key" do
        # when
        response = RestClient.get "http://127.0.0.1:23456/email/foo@gmail.com"
        # expect
        MultiJson.decode(response.to_s).keys.should include("email")
      end

    end

  end
end
