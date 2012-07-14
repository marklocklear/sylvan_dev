require 'fastercsv'

class Admin::ContestEntriesController < ApplicationController
  
  def index
    @contest_entries = ContestEntry.all
  end
  
  def new
    @contest_entry = ContestEntry.new

    respond_to do |format|
      format.html
    end
  end
  
  def show
    @contest_entry = ContestEntry.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    @contest_entry = ContestEntry.find(params[:id])
  end
  
  def update
    @contest_entry = ContestEntry.find(params[:id])

    respond_to do |format|
      if @contest_entry.update_attributes(params[:contest_entry])
        flash[:notice] = "ContestEntry was successfully updated #{params[:headline]} "  
        format.html { redirect_to("/admin/contest_entries/#{@contest_entry.id}/edit") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @contest_entry = ContestEntry.find(params[:id])
    @contest_entry.destroy

    respond_to do |format|
      format.html { redirect_to('/admin/contest_entries') }
    end
  end
  
  def export
    @contest_entries = ContestEntry.all
    
    respond_to do |format|
      format.csv { export_csv }
    end
  end
  
  protected
    def export_csv
      filename = I18n.l(Time.now, :format => :short) + " - ContestEntries.csv"
      content = gen_csv
      send_data content, :filename => filename
    end
    
    def gen_csv
      csv_header = [ "Entry #","First Name", "Last Name", "Email", "Address One", "Address Two", "City", "State", "Zip", "Gender", "Essay One", "Essay Two", "Blog", "Facebook", "Youtube", "Twitter", "Phone", "Age", "How Hear?", "Entry Date"]
      
      FasterCSV.generate do |csv|
        # add the header row first
        csv << csv_header
        
        ContestEntry.all.each do |entry|
          csv << [ entry[:id], entry[:first_name], entry[:last_name], entry[:email], entry[:address_one], entry[:address_two], entry[:city], entry[:state], entry[:zip], entry[:gender], entry[:essay_one], entry[:essay_two], entry[:blog], entry[:facebook], entry[:youtube], entry[:twitter], entry[:phone], entry[:age], entry[:how_hear], entry[:created_at] ]
        end
      end
    end
    
end
