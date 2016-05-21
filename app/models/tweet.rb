class Tweet < ActiveRecord::Base
    belongs_to :userTwitter
    validates :userTwitter_id, :body, presence: true
    before_create :post_to_twitter
    
    
    def post_to_twitter
        userTwitter.twitter.update(body)
    end
end