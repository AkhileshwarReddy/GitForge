class Project < ApplicationRecord
  has_one :repository_config, dependent: :destroy, inverse_of: :project

  accepts_nested_attributes_for :repository_config, update_only: true, reject_if: :all_blank
  validates_associated :repository_config

  attribute :path, :normalized_slug

  belongs_to :organisation, inverse_of: :projects, touch: true
  belongs_to :creator, class_name: "User",
    foreign_key: :creator_id, inverse_of: :created_projects

  enum :visibility, {
    private_vis: 0,
    internal_vis: 1,
    public_vis: 2
  }, default: :private_vis
end
