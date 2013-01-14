class Convertor

  @@default_convert_options = {
        :ar       => 44100,       #audio rate
        :q        => 1,           #audio quality 1..20
        :ab       => 128000       #audio bit rate        
      }

  ######################
  # Attribute accessors
  ######################
  attr_accessor :in_filename, :out_filename, :duration, :options, :destination_path

  
  ######################
  # Protected methods
  ######################
  protected
    
    def path
      return "#{destination_path.to_s}/#{out_filename.to_s}.mp3"
    end

    def stringify_options
      options_arr = []

      options.each do |k, v|
        options_arr << "-#{k.to_s.dup} #{v}"
      end

      return options_arr.join(" ")

    end

    def get_file_duration
      return nil if in_filename.nil? or in_filename.empty?  
      
      command = "#{ffmpeg} -i \"#{File.expand_path(in_filename)}\" 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//"
      command_output = `#{command}`
      
      
      if command_output =~ /([\d][\d]):([\d][\d]):([\d][\d]).([\d]+)/
        hours = $1; mins = $2; seconds = $3; mseconds = $4
        time_in_seconds = (( (hours.to_i * 60 + mins.to_i) * 60 + seconds.to_i) + (mseconds.to_f / 100).ceil).to_i
      end

      return Time.at(time_in_seconds).gmtime.strftime('%R:%S') if !time_in_seconds.nil? or !time_in_seconds.to_s.empty?

    end

    def ffmpeg
      @ffmpeg ||= `which ffmpeg`.chomp
    end

    def check_for_errors

      raise VideoToMp3Error, "No input file supplied" if in_filename.nil? or in_filename.empty?

      raise VideoToMp3Error, "Invalid options. It should be a hash" unless options.is_a?(Hash)

    end

    def set_default_attributes
      if out_filename.nil? or out_filename.empty?
        self.out_filename = in_filename.split("/")[-1].split(".")[0..-2].join("")
      end

      if destination_path.nil? or destination_path.empty?
        self.destination_path = "#{ENV["HOME"]}/mp3_files"

        raise VideoToMp3Error, "Unable to create directory at location - #{destination_path}" if 
          !Dir.exist?(destination_path) and !system("mkdir #{destination_path}")
      end

      if duration.nil?
        self.duration = get_file_duration   
      end
      
    end

end
