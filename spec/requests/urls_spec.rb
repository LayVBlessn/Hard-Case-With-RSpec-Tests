require 'rails_helper'


describe 'POST /urls' do
  it 'should return 302 Found' do
    post '/urls'
    expect(response).to have_http_status('302 Found')
  end
  it 'Should create and return short url' do
    expect do
      post '/urls', params: {url: 'youtube.com'}
      expect(response).to have_http_status(:success)
    end
  end
end

describe 'GET /urls/:short_url' do
  it 'should redirects to long url and encrease counter by 1' do
    query = create(:url, url: 'youtube.com', key: 'yt', counter: 0)
    get '/urls/yt'
    expect(response).to have_http_status('302 Found')
    expect((Url.find_by key: 'yt').counter).to eq(1)
  end
  it 'should return 302 Found and redirect to /urls' do
    get '/urls/123'
    expect(response).to have_http_status('302 Found')
  end
end

describe 'GET /urls/:short_url/stats' do
  it 'should return a number of redirections to long url' do
    query = create(:url, url: 'youtube.com', key: 'tt', counter: 0)
    get '/urls/tt'
    get '/urls/tt'
    get '/urls/tt/stats'
    expect(response).to have_http_status(:success)
    expect((Url.find_by key: 'tt').counter).to eq(2)
  end
end
