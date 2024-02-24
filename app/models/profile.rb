class Profile < ApplicationRecord

    validates :verified, inclusion: { in: [true, false] }

    validates  :phonenumber,presence: true,
    format: {with: /\A[6-9]\d{9}\z/, 
    message:"valid phone number"}

    validates  :email, presence: true
    #  format: 
    # {
    #     with: /\A[\w-\.]+@([\w-]+\.)+[\w-]{2,4}}z/,
    #  message: "valid Email"
    # }

    validates :firstname, format: {with:  /\A[A-Z][a-zA-Z]*\z/, 
    message: "Name start with capital letter"}, presence: true, 
    length: {minimum:3, maximum:20}
    
    validates :password, format:
     {with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum]])[A-Za-z\d[:punct:]]{8,}\z/, 
        message: "should include at least one lowercase letter,
       one uppercase letter, one digit, and one symbol"
    }, presence: true
    

    has_one_attached :image
    has_secure_password
    has_many :mobiles 
end
