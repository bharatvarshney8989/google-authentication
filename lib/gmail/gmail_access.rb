require 'gmail_xoauth'
require 'gmail'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'mail'
require 'monitor'
require 'fileutils'

   class GmailAccess
       def initialize(email,oauth_token)
          begin
             @imap = Net::IMAP.new('imap.googlemail.com', 993, usessl = true, certs = nil, verify = false)
             @imap.authenticate('XOAUTH2',email,oauth_token)
             @imap
          rescue Exception => e
            return "Error in Auth Token or email: #{e}"
         end
       end
       def capability
            synchronize do
            send_command("CAPABILITY")
            return @responses.delete("CAPABILITY")[-1]
          end
       end

       def display_message_id
            @imap.select("[Gmail]/All Mail")
            all_mail_id = @imap.search(["ALL"])
            all_mail_id
       end

       def total_message_count
          xmessages_count = @imap.status('INBOX', ['MESSAGES'])['MESSAGES']
          xmessages_count
      end

      def search(text, type='body')
          message_id = []
          byebug
          hash = {subject: 'SUBJECT', to: 'TO', from: 'FROM', cc: 'CC' , body: 'BODY'}
          message_id = @imap.search([hash[type.downcase.to_sym], text, "NOT", "NEW" ])
          message_id
      end

      def fetch_user_id

      end
      def disconnect
        @imap.disconnect
        return("Successfully disconnect!!")
      end
      def message_body( message_id = [])
          envelope = {}
          count = 0,i=0
          tmp = []
          
          while(message_id.count > count)
                  tmp[i]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (SUBJECT)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (FROM)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (to)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (BCC)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (CC)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_id[count], 'BODY[HEADER.FIELDS (BODY)]').to_s.split("{").second.chop
                  envelope[message_id] = tmp
                  tmp.clear
                 count += 1
          end
      end
   end
