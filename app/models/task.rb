class Task < ApplicationRecord
    belongs_to :user
    validates :title, presence: { message: I18n.t('notice.title_require') }
end
