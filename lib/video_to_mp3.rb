require "errors/video_to_mp3_error"

class VideoToMp3
  
  #method to convert thhe video file to mp3
  def connvert_to_mp3(input_filename, output_filename = nil, destination_path = "")
    raise VideoToMp3Error, "No input file supplied" if input_filename.nil? or input_filename.empty?

    #set the output filename sames as input filename if it is not supplied
    output_filename = input_filename.split("/")[-1] if output_filename.nil? or input_filename.empty?
    ffmpeg = `which ffmpeg`.chomp

    raise VideoToMp3Error, "Please install ffmpeg on your system. \n
                       Chackout the installation guide at http://ffmpeg.org/download.html
                      " if ffmpeg.nil? or ffmpeg.empty?

    if destination_path.nil? or destination_path.empty?
      #create the mp3_files directory
      default_path = "mp3_files"
      system("mkdir #{default_path}")
      destination_path = default_path
    end
    
    path = "#{destination_path}/#{output_filename}.mp3"
    ffmpeg_command = "#{ffmpeg} -i #{input_filename} -q 1 #{path}"

    puts "*********************************"
    puts ffmpeg_command
    puts "*********************************"

    #system method runs the command and return the true or false
    command_status = system(ffmpeg_command)

    if command_status == true
      return path
    else
      system("rm -rf #{default_path}")
      raise VideoToMp3Error, "Wrong file name or check the ffmpeg installation on your system"
    end

  end

end