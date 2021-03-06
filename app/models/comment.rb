class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_protected :spam_status, :post_id
  
  acts_as_snook :body_field => :text
  
  validates_presence_of :text, :name, :post_id, :email
  
  before_save :set_name_and_email
  
  def name
    self["name"] || user.login
  end
  
  alias_method :author, :name
  
  def email
    self["email"] || user.email
  end
  
  def body
    text
  end
  
  private
    def set_name_and_email
      if user
        self.name = user.login
        self.email = user.email
        self.url = user.url
      end
    end

end
