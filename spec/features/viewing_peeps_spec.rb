require 'timecop'

feature 'Visting the homepage' do
  scenario 'index page redirects to peeps homepage' do
    visit('/')
    expect(page).to have_content "Timeline"
  end
end

feature 'Viewing peeps' do
  scenario 'A user can view peeps and peep timestamps in reverse chronological order' do
    user = User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')

    Timecop.freeze(time = Time.now) do
      Peep.create(message: 'My first peep', peep_timestamp: time, user_id: user.id)
      Peep.create(message: 'Hello', peep_timestamp: time, user_id: user.id)
    end
    visit('/peeps')
    expect(page).to have_content("Hello Posted at: #{time.strftime("%Y-%m-%d %k:%M")}\nMy first peep Posted at: #{time.strftime("%Y-%m-%d %k:%M")}")
  end
end
