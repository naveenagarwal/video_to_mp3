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
gem "video_to_mp3", "~> 0.0.1"
```



Quick Start
-----------

In your code

VideoToMp3.new.connvert_to_mp3("\path\to\video\file", "outputfile_name", "\destination\path")

if you do not prove the output filename and destination path then inputfile name is set as 
outfile name and mp3_files directory get created if you donot provide the destination path

you can find the converted file at destination\path\outputfile_name.mp3


License
-------

video_to_mp3 is free software, and may be
redistributed under the terms specified in the MIT-LICENSE file.
