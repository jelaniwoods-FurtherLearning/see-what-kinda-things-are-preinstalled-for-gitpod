# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  owner          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Photo < ApplicationRecord

  belongs_to :user, foreign_key: "owner"
end
