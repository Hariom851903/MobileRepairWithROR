class ShopMailer < ApplicationMailer  
    default from: 'asatihariom95@gmail.com'
    def shop_email_message(profile)
        puts @profile
        @profile=profile
     begin
        mail(to: "#{@profile["email"]}", subject: 'Shop created succesfully')
        puts "successful send"
        rescue => e
            puts e.message
        end
     end
end  