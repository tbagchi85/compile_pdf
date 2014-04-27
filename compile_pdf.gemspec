# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compile_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = "compile_pdf"
  spec.version       = CompilePdf::VERSION
  spec.authors       = ["Tanmay Bagchi"]
  spec.email         = ["tbagchi85@gmail.com"]
  spec.description   = %q{If you have multiple format files like Image files(Eg. .png, .jpg, .jpeg etc.), Document files(Eg. .doc, .docx, text etc.)
                         or PDF files and now you want to make a single PDF with all format of files, this gem will help you to compile multiple
                         format files into single pdf.}
  spec.summary       = %q{If you have multiple format files like Image files(Eg. .png, .jpg, .jpeg etc.), Document files(Eg. .doc, .docx, text etc.)
                         or PDF files and now you want to make a single PDF with all format of files, this gem will help you to compile multiple
                         format files into single pdf.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "yomu", "~> 0.1.9"
  spec.add_dependency "prawn", "~> 1.0.0.rc2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'rake', '~> 10.1', '>= 10.1.0'
end
