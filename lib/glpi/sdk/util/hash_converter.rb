module GLPI
  module SDK
    module HashConverter
      def self.to_query(params)
        URI.encode_www_form(encode(params))
      end

      def self.encode(value, key = nil, out_hash = {})
        case value
        when Hash then
          value.each { |k, v| encode(v, append_key(key, k), out_hash) }
          out_hash
        when Array then
          value.each { |v| encode(v, "#{key}[]", out_hash) }
          out_hash
        when nil then ''
        else
          out_hash[key] = value
          out_hash
        end
      end

      def self.append_key(root_key, key)
        root_key.nil? ? :"#{key}" : :"#{root_key}[#{key.to_s}]"
      end

      private_class_method :append_key, :encode
    end
  end
end
