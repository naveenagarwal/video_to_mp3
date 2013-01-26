Note
------------

"VideoToMp3.new.connvert_to_mp3" to mp3 method would be same as convert method which is there in this release as I have made this a generic method which also gives you the fexibility to specify your own ffmpeg conversion options

Video to mp3
=========

This is a video to mp3 convertor. It converts your video files into mp3

Requirements
------------

ffmpeg must be installed on your system. For information on how to install ffmpeg please
check http://ffmpeg.org/download.html

Installation
------------

```ruby
gem "video_to_mp3", "~> 0.0.4"
```



Quick Start
-----------

In your code

You can intialize the code as you

video = VideoToMp3.new(input_filename, output_filename, {:ab => 64000, :ar => 22050, :destination_path => "destination/path"})

Then you will have method to convert into mp3 and the default location for the file will be "/home/username/mp3_files"

Just call video.convert and it will do the conversion

or

video = VideoToMp3.new

video.convert({
    :input_filename   => "/absolute/path/to/input/file",
    :output_filename  => "outputfile"                   #you dont need to add mp3 in the end,
    :destination_path => "/absolute/destination/path"   #this should be directory path
    #and any other option which which ffmpeg take for the mp3 audio conversion as key value pair
    #for eg :ab => 64000 --> audio bitrate '-ab 64000'
  })

incase you donot provide any options for conversion then it uses the default option which is
{
  :ar       => 44100,       #audio rate
  :q        => 1,           #audio quality 1..20
  :ab       => 128000       #audio bit rate        
}




convert_to_mp3 has been not changed and can be used as it was

  VideoToMp3.new.connvert_to_mp3("\path\to\video\file", "outputfile_name", "\destination\path")

  if you do not provide the output filename and destination path then inputfile name is set as 
  outputfile name and "mp3_files" directory get created if you do not provide the destination path

  you can find the converted file at destination\path\outputfile_name.mp3


Issue Report
------------
For any query or bug send me an email to naveenagarwal287@gmail.com
Also let me know if any one wish to write the test suite for it.

License
-------

video_to_mp3 is free software, and you are free to distribute it as is.
