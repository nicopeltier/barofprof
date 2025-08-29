class MessageTemplate < ApplicationRecord
  enum scope: { prof_email: 0, prof_welcome: 1, prof_end: 2, dir_invite: 3 }
  belongs_to :school, optional: true
end