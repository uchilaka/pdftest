class ProfilesController < ApplicationController

	def new 
	end 

	def create 
		#@profile = Profile.new(params[:profile])
		#profile_data = []
		#profile_data << params[:profile][:first_name]

=begin
		respond_to do |format|
			format.pdf { send_file ProfileSummary.new(params[:profile]).export, type: 'application/pdf' }
		end 
=end

		send_file ProfileSummary.new(params[:profile]).export, type: 'application/pdf'

		# render json: params[:profile].inspect
		# render json: profile_data.inspect
		# fill pdf form
	end 

	def edit
	end 

end
