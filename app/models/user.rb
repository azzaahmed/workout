class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :exercises

validates :first_name, presence: true
   validates :last_name, presence: true
   

  has_many :friendships
  # as we do not have a friend model we would use the user model by giving the :friend a class_name "user" so we are aliasing :friend
  has_many :friends, through: :friendships, class_name: "User"

    self.per_page = 10


   def full_name
    [first_name, last_name].join(" ")
  end


  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ?
        or last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end

# friendships.map(&:friend)   get all the friedships and select friend so we get all the current user friends
# .include?(new_friend)  check if the new friend we are passong already included in the returned list of the map
  # self == new_friend check if the current user is this new friend
  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end
  
end
