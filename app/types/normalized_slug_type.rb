class NormalizedSlugType < ActiveRecord::Type::Value
    def cast(value)
        return value if value.nil?
        value.to_s.strip.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
    end
end
