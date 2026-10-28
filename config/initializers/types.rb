Rails.application.config.to_prepare do
    ActiveRecord::Type.register(:normalized_slig, NormalizedSlugType)
end