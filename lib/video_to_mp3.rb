require "errors/video_to_mp3_error"
require "convertor/hash"
require "convertor/convertor"

class VideoToMp3 < Convertor

  def initialize(in_filename = nil, out_filename = nil, options = {})

    raise VideoToMp3Error, "Please install ffmpeg on your system. \n
                            Checkout the installation guide at http://ffmpeg.org/download.html
                           " if ffmpeg.nil? or ffmpeg.empty?

    raise VideoToMp3Error, "Invalid hash options" if !options.empty? and !options.is_a?(Hash)

    @in_filename  = in_filename
    @out_filename = out_filename
    @options      = options.symbolize_keys!
    @duration     = get_file_duration
  end

  ########################################################################################
  # options takes the hash which will allow user to set the custom quality parameter
  # for eg quality paramter q 1..20, audio rate ab 44100, 22050 etc
  ########################################################################################

  def convert(convert_options = {})
    self.options = convert_options

    #symbolize the hash keys
    self.options.symbolize_keys!
    
    #delete the input/output filename if exists in the options hash
    self.in_filename  = self.options.delete(:input_filename)    || in_filename
    self.out_filename = self.options.delete(:output_filename)   || out_filename
    
    #raises error in case it does not have the minimum required data t convert 
    check_for_errors
    
    #set the destionation path if exists in options has
    self.destination_path = self.options.delete(:destination_path)

    #check if options are empty now
    self.options = @@default_convert_options if options.empty?

    #returns the ffmpeg options hash as string for eg - '-ab 128000 -ac 2'
    options_string = stringify_options

    #set the deafult attributes if not present for eg - output filename duration etc
    set_default_attributes

    #convert to mp3
    ffmpeg_command = "#{ffmpeg} -i #{in_filename} #{options_string} #{path}"

    #system method runs the command and return the true or false
    command_status = system(ffmpeg_command)

    if command_status == true
      return path
    else
      raise VideoToMp3Error, "Wrong file name or check the ffmpeg installation on your system"
    end

  end

  
  #method to convert the video file to mp3
  def connvert_to_mp3(input_filename, output_filename = nil, destination_path = "")
    raise VideoToMp3Error, "No input file supplied" if input_filename.nil? or input_filename.empty?

    #set the output filename sames as input filename if it is not supplied
    output_filename = input_filename.split("/")[-1] if output_filename.nil? or input_filename.empty?

    raise VideoToMp3Error, "Please install ffmpeg on your system. \n
                       Checkout the installation guide at http://ffmpeg.org/download.html
                      " if ffmpeg.nil? or ffmpeg.empty?

    if destination_path.nil? or destination_path.empty?
      #create the mp3_files directory
      default_path = "#{ENV["HOME"]}/mp3_files"
      system("mkdir #{default_path}")
      destination_path = default_path
    end
    
    path = "#{destination_path}/#{output_filename}.mp3"
    ffmpeg_command = "#{ffmpeg} -i #{input_filename} -q 1 #{path}"

    #system method runs the command and return the true or false
    command_status = system(ffmpeg_command)

    if command_status == true
      return path
    else
      system("rm -rf #{default_path}")
      raise VideoToMp3Error, "Wrong file name or check the ffmpeg installation on your system"
    end

  end

  def options
    @options ||= {}
  end

  def duration
    @duration ||= get_file_duration
  end

end