require 'gmail_xoauth'
require 'gmail'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'mail'
require 'fileutils'
class SessionsController < ApplicationController
   def create
     byebug
      auth = request.env["omniauth.auth"]
      email = auth.info.email
      session[:omniauth] = auth.except('extra')
      user = User.from_omniauth(auth)
      session[:user_id] = user.id
      session[:user_auth_token] = user.oauth_token
      imap = Net::IMAP.new('imap.googlemail.com', 993, usessl = true, certs = nil, verify = false)
      byebug
      imap.authenticate('XOAUTH2', 'rajat.kumar@untroddenlabs.com', user.oauth_token)
      xmessages_count = imap.status('INBOX', ['MESSAGES'])['MESSAGES']
       puts xmessages_count
       search_result = imap.search(["OR", "FROM", "prem.saha@untroddenlabs.com", "TO", "navpreet@untroddenlabs.com"])

       imap.select("[Gmail]/All Mail")
       all_mail_id = imap.search(["ALL"])
       s1 = []
       s1[0]="SUBJECT"
       s1[1]="ready to go"
       s1[2]="trello"
       s1[3]="Codecademy"
       byebug
       imap.search([s1])
       #envelope = imap.fetch(all_mail_id[0], "ENVELOPE")
       #body = imap.fetch(all_mail_id[0],'BODY[TEXT]')[0].attr['BODY[TEXT]']
       imap.fetch(90, 'BODY[HEADER.FIELDS (SUBJECT)]').to_s.split("{").second.chop
       user_id=imap.uid_search(["SUBJECT", "Jedi"])
       mailbox_array = imap.list('','*').collect{ |mailbox| mailbox.name }
       mailbox_array.grep(/Sent/)
       body=imap.fetch(all_mail_id[0],'RFC822')[0].attr['RFC822']
       mail = Mail.read_from_string body
       msg = imap.fetch(all_mail_id[0],'RFC822')[0].attr['RFC822']
       mail = Mail.read_from_string msg
       puts mail.subject
       puts mail.text_part.body.to_s
       puts mail.html_part.body.to_s
       fetch_thread = Thread.start { imap.fetch(1..23, "UID") }
       search_result = imap.search(["FROM", "hello"])
       fetch_result = fetch_thread.value
       mail_count = imap.search(["SINCE", @since_date])
        puts "\n  Total Emails Since" + @since_date + mail_count.count.to_s
       #imap.examine('INBOX')
      redirect_to root_url, notice: "SIGNED IN"
   end

   def destroy
      session[:user_id] = nil
      session[:omniauth] = nil
      redirect_to root_url, notice: "SIGNED OUT"
   end
end
