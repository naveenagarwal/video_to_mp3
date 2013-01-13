$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name              = "video_to_mp3"
  s.version           = "0.0.5"
  s.platform          = Gem::Platform::RUBY
  s.author            = "Naveen Agarwal"
  s.email             = ["naveenagarwal287@gmail.com"]
  s.homepage          = "https://github.com/naveenagarwal/video_to_mp3.git"
  s.summary           = "Converts the video files into mp3 using ffmpeg"
  s.description       = "audio/video media convertor"

  s.require_paths = ["lib"]

  if File.exists?('UPGRADING')
    s.post_install_message = File.read("UPGRADING")
  end

  s.requirements << "ffmpeg"
  s.required_ruby_version = ">= 1.8.7"

  s.files = [
    "lib/video_to_mp3.rb",
    "lib/errors/video_to_mp3_error.rb",
    "README.md",
    "video_to_mp3.gemspec"
  ]

end