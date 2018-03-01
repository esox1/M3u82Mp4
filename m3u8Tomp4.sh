#!/bin/bash
#print some ECHO message to enter URL to the m3u8 to be converted to a mp4
#read the user URL
#ask if they want to save the output file in current direcotry or
#ask for the directory to save the output mp4 file..
#ask what the name of the output will be

echo -n "
███╗   ███╗██████╗ ██╗   ██╗ █████╗     ████████╗ ██████╗     ███╗   ███╗██████╗ ██╗  ██╗
████╗ ████║╚════██╗██║   ██║██╔══██╗    ╚══██╔══╝██╔═══██╗    ████╗ ████║██╔══██╗██║  ██║
██╔████╔██║ █████╔╝██║   ██║╚█████╔╝       ██║   ██║   ██║    ██╔████╔██║██████╔╝███████║
██║╚██╔╝██║ ╚═══██╗██║   ██║██╔══██╗       ██║   ██║   ██║    ██║╚██╔╝██║██╔═══╝ ╚════██║
██║ ╚═╝ ██║██████╔╝╚██████╔╝╚█████╔╝       ██║   ╚██████╔╝    ██║ ╚═╝ ██║██║          ██║
╚═╝     ╚═╝╚═════╝  ╚═════╝  ╚════╝        ╚═╝    ╚═════╝     ╚═╝     ╚═╝╚═╝          ╚═╝









"
read -p "Enter m3u8 URL:" URL
echo -n " Save MP4 file in the current directory (y/n)?: "
read YES_No

if  [[ "$YES_No" == "y" || "$YES_No" == "Y" || "$YES_No" == "" ]]
then
   CurrentDir=$(cd `dirname $0` && pwd)
   read -p "Name of the output mp4: " MP4numOut
   ffmpeg -allowed_extensions ALL -i "$URL" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 $CurrentDir/$MP4numOut.mp4
else

   read -p "Enter Directory of output (Enter Full path. i.e. /home/user/path/to/dir/): " MP4dir

   if [ ! -r "$MP4dir" ]
   then
       echo "$MP4dir path incorrect, or doesn't exist";
       # if not, exit with an exit code != 0
       exit 1;
   fi

   read -p "Enter the name of output mp4: " MP4numOut
   ffmpeg -allowed_extensions ALL -i "$URL" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 $MP4dir/$MP4numOut.mp4

fi
