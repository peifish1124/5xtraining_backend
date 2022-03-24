class Task < ApplicationRecord
    belongs_to :user
    validates :title, presence: { message: I18n.t('notice.title_require') }
    enum priority: { low: 0, middle: 1, high: 2 }
end
