class Task < ApplicationRecord
    paginates_per 5

    include AASM

    belongs_to :user
    validates :title, presence: { message: I18n.t('notice.title_require') }
    enum priority: { low: 0, middle: 1, high: 2 }

    aasm column: :status do 
        state :pending, initial: true
        state :ongoing, :done
    
        event :do_it do
            transitions from: :pending, to: :ongoing
        end

        event :finish_it do
            transitions from: :ongoing, to: :done
        end

        event :unfinish_it do
            transitions from: :done, to: :ongoing
        end
    end
end
