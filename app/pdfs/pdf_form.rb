class PdfForm

  attr_writer :template_path
  attr_reader :attributes

  def initialize
    fill_out
  end

  def export(output_file_path=nil)
    output_path = output_file_path || "#{Rails.root}/tmp/pdfs/#{SecureRandom.uuid}_#{self.class.name.underscore}.pdf" # make sure tmp/pdfs exists
    pdftk.fill_form template_path, output_path, attributes
    # output_path
    return output_path
  end

  def get_field_names 
    pdftk.get_field_names template_path
  end

  def template_path(path=nil)
    # @template_path ||= "#{Rails.root}/lib/pdf_templates/#{self.class.name.gsub('Pdf', '').underscore}.pdf" # makes assumption about template file path unless otherwise specified
  	if !path  
      @template_path ||= "#{Rails.root}/lib/pdf_templates/#{self.class.name.underscore}.pdf"
  	else 
  		@template_path = path
  	end 
  end

  protected

  def attributes(key_value_set=nil)
  	if key_value_set != nil
	  	raise 'Hash Array of attributes is required' if !key_value_set.is_a?(Hash)
	  	key_value_set.each do |key_value|
	  		attributes[key_value[:key].to_s] = key_value[:value]
	  	end 
  	else 
	    @attributes ||= {}
  	end
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

  def pdftk
    @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || '/usr/local/bin/pdftk') # On my Mac, the location of pdftk was different than on my linux server.
  end

  def fill_out
    raise 'Must be overridden by child class'
  end

end