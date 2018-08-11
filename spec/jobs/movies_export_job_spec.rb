require 'rails_helper'

RSpec.describe MoviesExportJob, type: :job do
  it "sends an email with exported movies" do
    movie1 = create(:movie, title: 'Shrek', description: 'Funny plot')
    movie2 = create(:movie, title: 'Lion King', description: 'Tears!')

    expected_csv = 'title;description
Shrek;Funny plot
Lion King;Tears!'

    user = create(:user, email: 'exporter@example.com')
    file_path = 'tmp/movies.csv'

    # can't make assert_difference to work
    # tried with gem and adding to spec_helper
    before = ActionMailer::Base.deliveries.size
    MoviesExportJob.perform_now(user, file_path)
    assert_equal ActionMailer::Base.deliveries.size, before + 1

    email = ActionMailer::Base.deliveries.last
    assert_equal 'exporter@example.com', email.to[0]

    file = File.open(file_path, "r")
    contents = file.read.strip
    assert_equal expected_csv, contents
  end
end
