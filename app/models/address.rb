class Address < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :street_address
  validates_presence_of :city
  validates             :state, presence: true, format: {with: /\w{2}/}, 
                                length: { is: 2 }
  validates             :zipcode, presence: true, format: {with: /\d{5}/}, 
                                  length: { is: 5 }
  validates_presence_of :kind, presence: true,
                               inclusion: {in: %w(billing, shipping)}

  belongs_to :user

end
