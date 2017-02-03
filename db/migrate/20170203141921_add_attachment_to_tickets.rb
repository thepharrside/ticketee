class AddAttachmentToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :attachment, :string
  end
end
