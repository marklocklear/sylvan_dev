class EntryMailer < ActionMailer::Base

  def entry_message(entry, sent_at = Time.now)
    @contest_entry = entry
    
    @subject    = "New Contest Entry E-mail ##{entry.id}"
    @body       = {}
    @recipients = 'contest@sylvansport.com'
    # @recipients = 'nathan@scullytown.com'
    @from       = 'no-reply@sylvansport.com'
    @sent_on    = sent_at
    @headers    = {}
    @body["email"] = 'test e-mail'
  end
end