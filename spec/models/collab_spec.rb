require 'capybara/rspec'

feature "ViewEditWikiButtonAsCollab" do

  background do 
    user = User.new(
    name: "Bob",
    username: "bob",
    email: "bob@test.com",
    password: 'password',
    address: "address",
    postcode: "postcode",
    state: "Casterly Rock",
    country: "MY"
    )
    user.skip_confirmation!
    user.save
    userid = user.id

    collaboration = Collaboration.new(
      wiki_id: 3,
      user_id: userid,
      )
    collaboration.save
  end

  scenario "Signing as a collaborator and viewing the edit button" do
    visit '/users/sign_in'
    within ('#users') do
      fill_in 'Email', :with => "bob@test.com"
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign In'
    click_link 'Woot'
    current_path.should == wiki_path
    expect(page).to have_selector(:link_or_button, 'Edit Wiki')
  end
end
