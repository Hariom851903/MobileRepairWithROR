class Otp < ApplicationRecord
      
           validates :email, presence: true 
           validates :otp, presence: true
          
        #    before_create :delete_otp
        #         def delete_otp 
        #             Otp.where('expiry_at <?',Time.now).destroy_all
        #         end  
        
            # after_touch :deleteotp 
            # def deleteotp
            #   byebug
            #     puts " chjbmds"
            #     Otp.where('expiry_at <?',Time.now).destroy_all
            # end                   
end
