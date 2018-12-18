class AddPosIdToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :pos, index: true
  end
end
