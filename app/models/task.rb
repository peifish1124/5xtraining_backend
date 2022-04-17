class Task < ApplicationRecord
    paginates_per 5

    belongs_to :user
    validates :title, presence: { message: I18n.t('notice.title_require') }
    enum priority: { low: 0, middle: 1, high: 2 }

    has_many :tag_relations
    has_many :tags, through: :tag_relations

    def all_tags
        tags.map(&:name).join('|')
    end

    def all_tags=(names)
        self.tags = names.split('|').map do |name|
            Tag.find_or_create_by(name: name)
        end
    end

    def do_it
        if status == 'pending'
         self.status = 'ongoing'
        end
    end

    def do_it!
        do_it
        save!
      end

    def finish_it
        if status == 'ongoing'
         self.status = 'done'
        end
    end

    def finish_it!
        finish_it
        save!
    end

    def unfinish_it
        if status == 'done'
         self.status = 'ongoing'
        end
    end

    def unfinish_it!
        unfinish_it
        save!
    end
end
