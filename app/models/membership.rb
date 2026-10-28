class Membership < ApplicationRecord
  belongs_to :organisation, inverse_of: :memberships
  belongs_to :user, inverse_of: :memberships

  enum :access_level, {
    guest: 10,
    reporter: 20,
    developer: 30,
    maintainer: 40,
    owner: 50
  }, validate: true
end
