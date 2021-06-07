require 'rails_helper'

describe 'Post review and rating' do
  describe 'happy path' do
    it 'can post reviews and ratings' do
      customer = create(:customer)
      tea = create_list(:tea, 10)
      review_params = [{:tea_id=>"#{tea.first.id}", rating: 8.2, review: 'Wow Great Tea'},
           {:tea_id=>"#{tea.second.id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.third.id}", rating: 6.2, review: 'Terrible tea'},
           {:tea_id=>"#{tea.fourth.id}", rating: 5.2, review: 'Not good at all'},
           {:tea_id=>"#{tea.fifth.id}", rating: 9.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea[5].id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea[6].id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea[7].id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea[8].id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.last.id}", rating: 8.2, review: 'I loved the taste'}]

        headers     = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/customers/#{customer.id}/customer_tea_reviews", headers:headers, params: JSON.generate(review_params)
        expect(response.status).to eq(201)
        reviews = JSON.parse(response.body, symbolize_names: true)
        expect(reviews).to be_a(Hash)
        expect(reviews[:data]).to eq("We appreciate your reviews!")
        expect(CustomerTeaReview.all.count).to eq(10)

    end

    it 'does not error out when less teas are sent back' do
      customer = create(:customer)
      tea = create_list(:tea, 10)
      review_params = [{:tea_id=>"#{tea.first.id}", rating: 8.2, review: 'Wow Great Tea'},
           {:tea_id=>"#{tea.second.id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.third.id}", rating: 6.2, review: 'Terrible tea'},
           {:tea_id=>"#{tea.fourth.id}", rating: 5.2, review: 'Not good at all'},
           {:tea_id=>"#{tea.fifth.id}", rating: 9.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.last.id}", rating: 8.2, review: 'I loved the taste'}]
           headers     = { 'CONTENT_TYPE' => 'application/json' }
           post "/api/v1/customers/#{customer.id}/customer_tea_reviews", headers:headers, params: JSON.generate(review_params)
           expect(response.status).to eq(201)
           reviews = JSON.parse(response.body, symbolize_names: true)
           expect(reviews).to be_a(Hash)
           expect(reviews[:data]).to eq("We appreciate your reviews!")
           expect(CustomerTeaReview.all.count).to eq(6)
    end
  end

  describe 'sad path' do
    it 'needs a customer' do
      customer = create(:customer)
      tea = create_list(:tea, 10)
      review_params = [{:tea_id=>"#{tea.first.id}", rating: 8.2, review: 'Wow Great Tea'},
           {:tea_id=>"#{tea.second.id}", rating: 8.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.third.id}", rating: 6.2, review: 'Terrible tea'},
           {:tea_id=>"#{tea.fourth.id}", rating: 5.2, review: 'Not good at all'},
           {:tea_id=>"#{tea.fifth.id}", rating: 9.2, review: 'I loved the taste'},
           {:tea_id=>"#{tea.last.id}", rating: 8.2, review: 'I loved the taste'}]
           headers     = { 'CONTENT_TYPE' => 'application/json' }
           post "/api/v1/customers/#{1}/customer_tea_reviews", headers:headers, params: JSON.generate(review_params)
           expect(response.status).to eq(404)
            sad = JSON.parse(response.body, symbolize_names: true)
           expect(sad).to be_a(Hash)
           expect(sad[:error]).to eq("Couldn't find Customer with 'id'=1")
    end
  end
end
