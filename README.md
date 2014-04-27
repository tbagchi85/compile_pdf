# Compile Pdf

If you have multiple format files like Image files(Eg. .png, .jpg, .jpeg etc.), Document files(Eg. .doc, .docx, text etc.)

or PDF files and now you want to make a single PDF with all format of files,

this gem will help you to compile multiple format files into single pdf.


## Installation

Add this line to your application's Gemfile:

    gem 'compile_pdf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install compile_pdf

## Usage

Currently this is only supported with following format files:-

1. Image Files(Eg. .PNG, .JPG, .JPEG etc.)
2. PDF files(Eg. .pdf)
3. Text and Note files(Eg. .txt etc. )
4. Document files(Eg. .docx, .doc etc.)

Open Rails console:-

 > require 'compile_pdf'

 > extend CompilePdf

 > compile_pdf_module(file_array, attachment_object_name, file_name = nil)

   file_array:  Take the required files which you want to convert into a pdf

   attachment_object_name: If you are using PaperClip as File uploader module

     has_attached_file :attachment

   Then your attachment_object_name will be "attachment"

   file_name: Default will be Time.now or else you can specify your own PDF name.


  For Example:--

     file_array = File.all

   In your File model if

     has_attached_file :attachment

   attachment_object_name = "attachment"

   file_name = "my_attachment"

     compile_pdf_module(file_array, attachment_object_name, file_name)

 Default file location will be Your Project root folder "tmp/" folder

 I have tested with PaperClip and Aws S3 and its working fine.

 Soon I will release for "Dragonfly", "attachment_fu" and "CarrierWave" attachment gem.


## Dependency

This gem is highly dependent on :-

  1. gem "yomu", "~> 0.1.9" , :platforms => :ruby
  2. gem "prawn", "~> 1.0.0.rc2" , :platforms => :ruby

  If you have any other version of Prawn it may conflict with 'Compile Pdf' gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
