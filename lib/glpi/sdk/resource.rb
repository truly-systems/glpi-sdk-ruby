module GLPI
  module SDK
    class Resource
      def initialize(attributes = {})
        @attributes = attributes
      end

      def self.create(session, attributes = {})
        item_type = attributes.key?(:item_type) ? attributes.delete(:item_type) : type_name
        payload = { input: attributes }.to_json
        response = session.request :post, "/#{item_type}", body: payload
        find(session, response['id'], item_type)
      end

      def self.update(session, id, attributes = {})
        item_type = attributes.key?(:item_type) ? attributes.delete(:item_type) : type_name
        payload = { input: attributes }.to_json
        session.request :put, "/#{item_type}/#{id}", body: payload
        find(session, id, item_type)
      end

      def self.destroy(session, id, item_type = nil)
        item_type ||= type_name
        payload = { force_purge: true }.to_json
        response = session.request :delete, "/#{item_type}/#{id}", body: payload
        response[0][id.to_s]
      end

      def self.find(session, id, item_type = nil)
        item_type ||= type_name
        response = session.request :get, "/#{item_type}/#{id}"
        new(response)
      end

      def self.all(session, **params)
        item_type = params.key?(:item_type) ? params.delete(:item_type) : type_name
        endpoint = "/#{item_type}"
        endpoint += "?#{HashConverter.to_query(params)}" if params
        response = session.request :get, endpoint
        response.map { |item| new(item) }
      end

      class << self
        alias where all
      end

      def self.type_name
        name.split('::').last
      end

      private

      def method_missing(name, *args, &block)
        @attributes.key?(name.to_s) ? @attributes[name.to_s] : super
      end

      def respond_to_missing?(name, include_private = false)
        @attributes.key?(name.to_s)
      end
    end
  end
end
