class Todo < ApplicationRecord
  after_create do
    broadcast_replace_to(
      'new_form',
      target: 'new_form',
      partial: 'todos/form',
      locals: { todo: Todo.new }
    )

    broadcast_prepend_to(
      'todos',
      target: 'todos',
      partial: 'todos/todo',
      locals: { todo: self }
    )
  end

  after_destroy do
    broadcast_remove_to(
      'todos',
      target: "todo_#{id}"
    )
  end
end
