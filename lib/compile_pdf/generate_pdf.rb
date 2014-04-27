module CompilePdf

  def compile_pdf_module(attachments, attachment_type, file_name = nil)
    arr = []
    attachments.each do |a|
      if file_type(a, attachment_type) == "application" && is_pdf?(a, attachment_type)
        arr <<  attachment_type(a, attachment_type).to_s
      end
    end

    file_name = file_name_generate(file_name)

    Prawn::Document.generate(file_name) do  |phr|
      attachments.each do |a|
        if file_type(a, attachment_type) == "application" && is_pdf?(a, attachment_type)
          generate_pdf(phr,a, attachment_type)
        elsif a.file_type == "image"
          generate_image(phr,a, attachment_type)
        elsif file_type(a, attachment_type) != "not_found" && is_pdf?(a, attachment_type) != "not_found"
          generate_text(phr,a, attachment_type)
        end
      end
    end
  end

  def attachment_type(file, attachment_type)
    file.send(attachment_type)
  end

  def file_name_generate(file_name)
    if file_name
      "#{Rails.root}/tmp/#{file_name}.pdf"
    else
      "#{Rails.root}/tmp/#{Time.now}_phr.pdf"
    end
  end

  def merge(pdf_paths, destination)
    first_pdf_path = pdf_paths.delete_at(0)
    Prawn::Document.generate(destination, :template => first_pdf_path) do |pdf|
      pdf_paths.each do |pdf_path|
        pdf.go_to_page(pdf.page_count)
        template_page_count = count_pdf_pages(pdf_path)
        (1..template_page_count).each do |template_page_number|
          pdf.start_new_page(:template => pdf_path, :template_page => template_page_number)
        end
      end
    end
  end

  def count_pdf_pages(pdf_file_path)
    pdf = Prawn::Document.new(:template => pdf_file_path)
    pdf.page_count
  end

  def generate_image(phr,a, attachment_type)
    phr.go_to_page(phr.page_count)
    phr.start_new_page
    file_path = attachment_type(a, attachment_type).to_s
    phr.move_down 5
    phr.image open(file_path, 'User-Agent' => 'ruby'), :position => :center, :fit => [600, 700]
  end

  def generate_pdf(phr,a, attachment_type)
    file_path = attachment_type(a, attachment_type).to_s
    file_path = open(file_path, 'User-Agent' => 'ruby')
    phr.go_to_page(phr.page_count)
    template_page_count = count_pdf_pages(file_path)
    (1..template_page_count).each do |template_page_number|
      phr.start_new_page(:template => file_path, :template_page => template_page_number,:size => "LEGAL", :layout => :landscape, :margin => 0)
    end
  end

  def generate_text(phr, a, attachment_type)
    phr.go_to_page(phr.page_count)
    phr.start_new_page
    path = attachment_type(a, attachment_type).to_s
    open_file = open(path, 'User-Agent' => 'ruby')
    data = open_file.read
    content = Yomu.read :text, data
    phr.move_down 5
    phr.text content
  end

  def file_type(attachment, attachment_type)
    attachment.respond_to?("#{attachment_type}_content_type") ? attachment.send("#{attachment_type}_content_type").split('/').first : "not_found"
  end

  def is_pdf?(attachment, attachment_type)
    attachment.respond_to?("#{attachment_type}_content_type") ? attachment.send("#{attachment_type}_content_type").split('/').last == "pdf" : "not_found"
  end

end
