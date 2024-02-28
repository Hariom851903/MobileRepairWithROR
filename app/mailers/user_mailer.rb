
class UserMailer < ApplicationMailer
    default from: 'asatihariom95@gmail.com'
    def welcome_email(otpdata)
        @otpdata=otpdata
     begin
        mail(to: "#{@otpdata.email}", subject: 'Verification mail')
        puts "successful send"
        rescue => e
            puts e.message
        end
     end

end