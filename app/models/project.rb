class Project < ApplicationRecord
  belongs_to :organisation
  belongs_to :creator
end
