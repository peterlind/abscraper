#endcoding:utf-8
require 'spec_helper'

feature 'search for company' do

  scenario 'results found' do
    VCR.use_cassette('ab-apoex') do
      visit root_url
      fill_in 'query_input', with: 'apoex ab'
      click_button 'Sök'
      page.should have_content '556633-4149'
    end
  end

  scenario 'no results found' do
    VCR.use_cassette('ab-asdafasdaf') do
      visit root_url
      fill_in 'query_input', with: 'asdafasdaf'
      click_button 'Sök'
      page.should have_content 'Inga bolag hittades'
    end
  end

end
