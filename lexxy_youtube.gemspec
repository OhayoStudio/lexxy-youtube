require_relative "lib/lexxy_youtube/version"

Gem::Specification.new do |spec|
  spec.name        = "lexxy-youtube"
  spec.version     = LexxyYoutube::VERSION
  spec.authors     = [ "Jérôme Sadou" ]
  spec.email       = [ "jerome@ohayostudio.com" ]
  spec.summary     = "YouTube embed extension for Lexxy rich-text editors"
  spec.description = "Automatically converts pasted YouTube URLs to responsive iframe embeds and adds a toolbar button with a URL input dropdown. Ships as a Rails engine asset for importmap-based apps."
  spec.homepage    = "https://github.com/OhayoStudio/lexxy-youtube"
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.1"

  spec.files = Dir[
    "app/**/*",
    "lib/**/*",
    "LICENSE",
    "README.md"
  ]

  spec.add_dependency "railties", ">= 7.0", "< 9"
end
