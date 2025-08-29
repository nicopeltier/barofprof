require "test_helper"

class TeacherMailerTest < ActionMailer::TestCase
  test "invite" do
    mail = TeacherMailer.invite
    assert_equal "Invite", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "reminder" do
    mail = TeacherMailer.reminder
    assert_equal "Reminder", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
