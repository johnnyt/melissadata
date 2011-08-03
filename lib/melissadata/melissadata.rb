$LOAD_PATH.unshift File.expand_path('..', File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.expand_path('..', File.dirname(__FILE__)))

require 'rubygems'
require 'active_support/core_ext'
require 'melissa-data/version'
require 'melissa-data/constants'

module MelissaData
  module_function

  ENVIRONMENTS = [:development, :production, :vagrant, :test, :staging]

  # Retrieves the current MelissaData environment
  #
  # @return [String] the current environment
  def env
    @env or fail "environment has not been set"
  end

  # Sets the current MelissaData environment
  #
  # @param [String|Symbol] env the environment symbol of [dev | development | prod | production | test]
  def env=(e)
    es = case(e.to_sym)
    when :dev  then :development
    when :prod then :production
    else e.to_sym
    end

    if ENVIRONMENTS.include?(es)
      @env = es
    else
      fail "did not recognize environment: #{e}, expected one of: #{ENVIRONMENTS.join(', ')}"
    end
  end

  def client=(c)
    @client = c
  end

  def client
    raise "Client has not yet been setup" if @client.nil?
    @client
  end

  def lib_path
    @lib_path ||= File.dirname(__FILE__)
  end

  # Determines if we are in the production environment
  #
  # @return [Boolean] true if current environment is production, false otherwise
  def prod?
    env == :production
  end

  # Determines if we are in the development environment
  #
  # @return [Boolean] true if current environment is development, false otherwise
  def dev?
    env == :development
  end

  # Determines if we are in the test environment
  #
  # @return [Boolean] true if current environment is test, false otherwise
  def test?
    env == :test
  end

  # Determines if we are in the staging environment
  #
  # @return [Boolean] true if current environment is staging.
  def staging?
    env == :staging
  end

  # Determines if we are in the vagrant environment
  #
  # @return [Boolean] true if current environment is vagrant.
  def vagrant?
    env == :vagrant
  end
end
