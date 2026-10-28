class RepositoryConfig < ApplicationRecord
  belongs_to :project, inverse_of: :repository_config
  has_one :organisation, through: :project
end
