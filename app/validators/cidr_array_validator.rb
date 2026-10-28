require "ipaddr"

class CidrArrayValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return if value.nil?
        unless value.is_a?(Array)
            record.errors.add(attribute, :not_an_array, message: "must be an array of CIDR strings")
            return
        end

        value.each do |cidr|
            IPAddr.new(cidr.to_s)
        rescue IPAddr::Error
            record.errors.add(attribute, :invalid_cidr, message: "contains invalid CIDR %{cidr}", cidr: cidr)
        end
    end
end
