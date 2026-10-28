class Project < ApplicationRecord
  attribute :path, :normalized_slug

  belongs_to :organisation, inverse_of: :projects, touch: true
  belongs_to :creator, class_name: 'User',
    foreign_key: :creator_id, inverse_of: :created_projects

  enum :visibility, {
    private_vis: 0,
    internal_vis: 1,
    public_vis: 2
  }, default: :private_vis
end
