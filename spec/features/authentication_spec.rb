feature 'authentication' do
  scenario 'a user can sign in' do
    User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')

    visit '/sessions/new'
    fill_in(:username, with: 'ChitterTester')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).to have_content '@ChitterTester'
  end

  scenario 'a user sees an error if they get their username wrong' do
    User.create(name: 'Tester', username: 'ChitterTester', email: 'test@example.com', password: 'password123')

    visit '/sessions/new'
    fill_in(:username, with: 'nottherightusername')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).not_to have_content '@nottherightusername'
    expect(page).to have_content 'Please check your username or password.'
  end
end
