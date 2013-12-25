class CreateOrganizerInvitations < ActiveRecord::Migration
  def change
    create_table :organizer_invitations do |t|
      t.integer :inviter_id, null: false
      t.integer :invitee_id
      t.string :invitee_email, null: false
      t.string :token, null: false
      t.integer :conference_edition_id, null: false

      t.timestamps
    end
  end
end
