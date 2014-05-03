class ProfileSummary < PdfForm

	def initialize(profile)
		@profile = profile 
		super()
	end 

	protected 

	def fill_out
		[:first_name, :last_name, :dob].each do |f|
			fill f, @profile[f]
		end 
	end 		

end