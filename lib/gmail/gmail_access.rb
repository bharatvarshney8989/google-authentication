require 'gmail_xoauth'
require 'gmail'
require 'google/apis/gmail_v1'
require 'googleauth/stores/file_token_store'
require 'mail'
require 'fileutils'

module gmail
   class gmail_access
       def initialize(email,oauth_token)
           @imap = Net::IMAP.new('imap.googlemail.com', 993, usessl = true, certs = nil, verify = false)
           @imap.authenticate('XOAUTH2',email,oauth_token)
           @imap
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
      def search(text, type)
          message_id = []
        if type.casecamp?("subject")
              message_id=imap.search(["SUBJECT",type,"NOT","NEW" ])
        else if type.casecamp?("to")
              message_id=imap.search(["to",type,"NOT","NEW" ])
        else if type.casecamp?("bcc")
              message_id=imap.search(["BCC",type,"NOT","NEW" ])
        else if type.casecamp?("cc")
              message_id=imap.search(["SUBJECT",type,"NOT","NEW" ])
        else if type.casecamp?("body")
              message_id=imap.search(["BODY",type,"NOT","NEW" ])
        end
      end

   end
end
