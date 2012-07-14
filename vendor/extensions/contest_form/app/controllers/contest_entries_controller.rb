class ContestEntriesController < ApplicationController
  
  radiant_layout "form-layout"
  no_login_required
  
  def new
    @contest_entry = ContestEntry.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @contest_entry = ContestEntry.new(params[:contest_entry])

    respond_to do |format|
      if @contest_entry.save
        
        entry_email = EntryMailer.create_entry_message(@contest_entry)
        EntryMailer.deliver(entry_email)
        
        format.html { redirect_to('/contest/thanks/') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def thanks
    
  end
  
end
