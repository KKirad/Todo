class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :nullify
  validates :title, presence: true, length: { maximum: 60 }, format: { with: /\A[a-zA-Z\d ]+\z/ }

  scope :search, -> (title) { where('title like ?', "#{title}%") }
  scope :pagination, -> (page, limit) { paginate(page: page, per_page: limit) }
  
  def self.trash
  	unscope(where: :is_deleted).joins("INNER JOIN todo_items ON todo_items.todo_list_id = todo_lists.id"
      ).where(todo_items: {is_deleted: true}).distinct
  end

  def deleted_todo_items
  	todo_items.unscope(where: :is_deleted).where(is_deleted: true)
  end

  def as_json(options = { })
    super((options || { }).merge({
        :methods => [:todo_items, :deleted_todo_items]
    }))
  end
end
