require 'rails_helper'

feature "User views list of all comics" do
  let!(:user) do
    FactoryGirl.create(:user)
  end
  let!(:first_comic) do
    FactoryGirl.create(:comic)
  end
  let!(:second_comic) do
    FactoryGirl.create(:comic, publisher: 'Image', title: 'Wytches', writer: 'Scott Snyder')
  end
  let!(:third_comic) do
    FactoryGirl.create(:comic, publisher: 'Image', title: 'Saga', writer: 'Brian K Vaughn', artist: 'Fiona Staples')
  end
  let!(:first_user_subscription) do
    FactoryGirl.create(:subscription, user: user, comic: first_comic)
  end
  let!(:second_user_subscription) do
    FactoryGirl.create(:subscription, user: user, comic: second_comic)
  end
  let!(:cap_marvel) do
    FactoryGirl.create(:comic, title: "Captain Marvel (2016 - Present)")
  end
  let!(:ironman) do
    FactoryGirl.create(:comic, title: "Iron Man Annual (1970 - 1994)")
  end
  let!(:black_panther) do
    FactoryGirl.create(:comic, title: "Black Panther (2016 - Present)")
  end
  let!(:black_widow) do
    FactoryGirl.create(:comic, title: "Black Widow (2010)")
  end

  scenario 'a user can add a comic to their subscriptions list' do
    @cap_marvel = cap_marvel
    @ironman = ironman
    @black_panther = black_panther
    @black_widow = black_widow
    visit root_path
    sign_in_as(user)
    visit comic_path(third_comic)
    click_link "Add Subscription"
    expect(page).to have_content "3 CURRENT SUBSCRIPTION(S):"
    expect(page).to have_link(first_comic.title)
    expect(page).to have_link(second_comic.title)
    expect(page).to have_link(third_comic.title)
  end

end
