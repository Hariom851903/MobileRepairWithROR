class OrderMailer < ApplicationMailer 
    default from: 'asatihariom95@gmail.com'
    def order_mail(tracking,mobile,user)
        @profile=user
        @trcking=tracking
        @mobile=mobile 
     begin
        mail(to: "#{@profile["email"]}", subject: 'Order created succesfully')
        puts "successful send"
        rescue => e
            puts e.message
        end
     end
end
