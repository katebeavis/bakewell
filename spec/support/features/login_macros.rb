module LoginMacros
  def sign_in(user)
    visit root_path
    click_link 'Get started'
    expect(page).to have_content('Log in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
