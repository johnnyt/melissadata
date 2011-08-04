# This file contains all of the internal errors in MelissaData's core
# commands, actions, etc.

module MelissaData
  # This module contains all of the internal errors in MelissaData's core.
  # These errors are _expected_ errors and as such don't typically represent
  # bugs in MelissaData itself. These are meant as a way to detect errors and
  # display them in a user-friendly way.
  #
  # # Defining a new Error
  #
  # To define a new error, inherit from {MelissaDataError}, which lets MelissaData
  # know that this is an expected error, and also gives you some helpers for
  # providing exit codes and error messages. An example is shown below, then
  # it is explained:
  #
  #     class MyError < MelissaData::Errors::MelissaDataError
  #       error_key "my_error"
  #     end
  #
  # This creates an error with an I18n error key of "my_error." {MelissaDataError}
  # uses I18n to look up error messages, in the "melissadata.errors" namespace. So
  # in the above, the error message would be the translation of "melissadata.errors.my_error"
  #
  # If you don't want to use I18n, you can override the {#initialize} method and
  # set your own error message.
  #
  # # Raising an Error
  #
  # To raise an error, it is nothing special, just raise it like any normal
  # exception:
  #
  #     raise MyError.new
  #
  # Eventually this exception will bubble out to the `melissadata` binary which
  # will show a nice error message. And if it is raised in the middle of a
  # middleware sequence, then {Action::Warden} will catch it and begin the
  # recovery process prior to exiting.
  module Errors
    # Main superclass of any errors in MelissaData. This provides some
    # convenience methods for setting the error key.  The error key is
    # used as a default message from I18n.
    class MelissaDataError < StandardError
      def self.error_key(key=nil, namespace=nil)
        define_method(:error_key) { key }
        error_namespace(namespace) if namespace
      end

      def self.error_namespace(namespace)
        define_method(:error_namespace) { namespace }
      end

      def initialize(message=nil, *args)
        message = { :_key => message } if message && !message.is_a?(Hash)
        message = { :_key => error_key, :_namespace => error_namespace }.merge(message || {})
        message = translate_error(message)

        super
      end

      # The default error namespace which is used for the error key.
      # This can be overridden here or by calling the "error_namespace"
      # class method.
      def error_namespace; "melissadata.errors"; end

      # The key for the error message. This should be set using the
      # {error_key} method but can be overridden here if needed.
      def error_key; nil; end

      protected

      def translate_error(opts)
        return nil if !opts[:_key]
        I18n.t("#{opts[:_namespace]}.#{opts[:_key]}", opts)
      end
    end

    class DiscNotFound < MelissaDataError
      error_key(:disc_not_found)
    end

  end
end
