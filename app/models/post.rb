class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :category

	has_attached_file :post_image, styles: { large: "600x600", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :post_image, content_type: /\Aimage\/.*\Z/
	
end
