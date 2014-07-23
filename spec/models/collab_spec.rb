require 'rails_helper'

feature "ViewEditWikiButtonAsCollab" do

  background do 
    user1 = User.new(
    name: "Bob",
    username: "bob",
    email: "bob@test.com",
    password: 'password',
    address: "address",
    postcode: "postcode",
    state: "Casterly Rock",
    country: "MY"
    )
    user1.skip_confirmation!
    user1.save!
    userid = user1.id

    user2 = User.new(
      name: "Adam",
      username: "adam",
      email: "email@test.com",
      password: 'password',
      address: "address",
      postcode: "postcode",
      state: "winterfel",
      country: "MY"
    )
    user2.skip_confirmation!
    user2.save!
    ownerid = user2.id

    @wiki = Wiki.new(
      name: "name",
      body: "body",
      public: true,
      user_id: ownerid
      )
    @wiki.save!

    collaboration = Collaboration.new(
      wiki_id: @wiki.id,
      user_id: userid,
      )
    collaboration.save!
  end

  scenario "Signing as a collaborator and viewing the edit button" do
    visit '/users/sign_in'
    within ('#new_user') do
      fill_in 'Email', :with => "bob@test.com"
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign in'
    click_link 'name'
    expect(current_path).to eq(wiki_path(@wiki))
    expect(page).to have_selector(:link_or_button, 'Edit Wiki')
  end
end
