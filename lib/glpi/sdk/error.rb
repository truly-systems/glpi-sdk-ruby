module GLPI
  module SDK
    module Error
      ERRORS = {
        'ERROR_ITEM_NOT_FOUND'                    => 'ItemNotFoundError',
        'ERROR_BAD_ARRAY'                         => 'BadArrayError',
        'ERROR_METHOD_NOT_ALLOWED'                => 'MethodNotAllowedError',
        'ERROR_RIGHT_MISSING'                     => 'RightMissingError',
        'ERROR_SESSION_TOKEN_INVALID'             => 'SessionTokenInvalidError',
        'ERROR_SESSION_TOKEN_MISSING'             => 'SessionTokenMissingError',
        'ERROR_APP_TOKEN_PARAMETERS_MISSING'      => 'AppTokenParametersMissingError',
        'ERROR_NOT_DELETED'                       => 'NotDeletedError',
        'ERROR_NOT_ALLOWED_IP'                    => 'NotAllowedIPError',
        'ERROR_LOGIN_PARAMETERS_MISSING'          => 'LoginParametersMissingError',
        'ERROR_LOGIN_WITH_CREDENTIALS_DISABLED'   => 'LoginWithCredentialsDisabledError',
        'ERROR_GLPI_LOGIN_USER_TOKEN'             => 'LoginUserTokenError',
        'ERROR_GLPI_LOGIN'                        => 'LoginError',
        'ERROR_ITEMTYPE_NOT_FOUND_NOR_COMMONDBTM' => 'ItemTypeNotFoundNorCommonDBTMError',
        'ERROR_SQL'                               => 'SQLError',
        'ERROR_RANGE_EXCEED_TOTAL'                => 'RangeExceedTotalError',
        'ERROR_GLPI_ADD'                          => 'AddError',
        'ERROR_GLPI_PARTIAL_ADD'                  => 'PartialAddError',
        'ERROR_GLPI_UPDATE'                       => 'UpdateError',
        'ERROR_GLPI_PARTIAL_UPDATE'               => 'PartialUpdateError',
        'ERROR_GLPI_DELETE'                       => 'DeleteError',
        'ERROR_GLPI_PARTIAL_DELETE'               => 'PartialDeleteError'
      }.freeze

      class ItemNotFoundError < StandardError; end
      class BadArrayError < StandardError; end
      class MethodNotAllowedError < StandardError; end
      class RightMissingError < StandardError; end
      class SessionTokenInvalidError < StandardError; end
      class SessionTokenMissingError < StandardError; end
      class AppTokenParametersMissingError < StandardError; end
      class NotDeletedError < StandardError; end
      class NotAllowedIPError < StandardError; end
      class LoginParametersMissingError < StandardError; end
      class LoginWithCredentialsDisabledError < StandardError; end
      class LoginUserTokenError < StandardError; end
      class LoginError < StandardError; end
      class ItemTypeNotFoundNorCommonDBTMError < StandardError; end
      class SQLError < StandardError; end
      class RangeExceedTotalError < StandardError; end
      class AddError < StandardError; end
      class PartialAddError < StandardError; end
      class UpdateError < StandardError; end
      class PartialUpdateError < StandardError; end
      class DeleteError < StandardError; end
      class PartialDeleteError < StandardError; end

      def self.dispatch(type, message)
        raise constantize(type), message
      end

      def self.constantize(type)
        error_class = ERRORS[type]
        error_class = error_class ? "#{self}::#{error_class}" : 'StandardError'

        Object.const_get(error_class)
      end

      private_class_method :constantize
    end
  end
end
