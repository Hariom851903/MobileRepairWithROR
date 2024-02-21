class Otp < ApplicationRecord
           validates :email, presence: true 
           validates :otp, presence: true


           before_commit :delete_otp
           before_validation  :generate_otp    
           before_create :expiry_time
         
           private 
                def generate_otp
                 self.otp=(((rand*8999)+1000).ceil).to_s
                end
                def expiry_time 
                   self.expiry_at=(Time.now)+60*5
                end
                def delete_otp 
                    Otp.where('expiry_at <?',Time.now).destroy_all
                end                    
end
