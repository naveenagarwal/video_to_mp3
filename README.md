Video to mp3
=========

This is a video to mp3 convertor. iT converts your video files into mp3

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
