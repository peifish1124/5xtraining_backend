class Tag < ApplicationRecord
    has_many :tag_relations
    has_many :tasks, through: :tag_relations
end