#!/bin/bash
##################################################################################
##### LICENSE ####################################################################
##################################################################################
####                                                                          ####
#### Copyright (C) 2018 wuseman <info@sendit.nu>                              ####
####                                                                          ####
#### This program is free software: you can redistribute it and/or modify     ####
#### it under the terms of the GNU General Public License as published by     ####
#### the Free Software Foundation, either version 3 of the License, or        ####
#### (at your option) any later version.                                      ####
####                                                                          ####
#### This program is distributed in the hope that it will be useful,          ####
#### but WITHOUT ANY WARRANTY; without even the implied warranty of           ####
#### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            ####
#### GNU General Public License at <http://www.gnu.org/licenses/> for         ####
#### more details.                                                            ####
####                                                                          ####
##################################################################################
##### GREETINGS ##################################################################
##################################################################################
####                                                                          ####
#### To all developers that contributes to all kind of open source projects   ####
#### Keep up the good work!                                                   #<3#
####                                                                          ####
#### https://sendit.nu & https://github.com/wuseman                           ####
####                                                                          ####
##################################################################################
#### DESCRIPTION #################################################################
##################################################################################
####                                                                          ####
#### Take control over the hidden metadata for your pitures                   ####
####                                                                          ####
####                                                                          ####
#### In case they will go down or soemthing i the list is stored in           ####
#### the filelist in ./sec-us-archive.txt                                     ####
####                                                                          ####
#### Author:  wuseman                                                         ####
#### Contact: wuseman@nr1.nu                                                  ####
#### IRC:     wuseman @ Freenode.com                                          ####
#### Distro:  This script has been tested on: Gentoo / Raspian(Debian)        ####
####                                                                          ####
#### Usage:   bash wexif.sh --help                                            ####
####                                                                          ####
#### Enjoy another awesome 'bash' script from wuseman. Questions? Conact me!  ####
####                                                                          ####
##################################################################################
#### Begin of code  ##############################################################
##################################################################################

which exif &> /dev/NULL
if [[ $? -gt "0" ]]; then
   printf "%s\n" "This tool require 'exif' to be installed"
   exit 1
fi



banner() {
cat <<EOF

     _n_|_|_._
    |===.-.===|  Take control over your images
    |  ((_))  |  
    .====-====.        Author: wuseman

EOF
}

if [[ -z $1 ]]; then
   banner
   exit 0
fi

case $1 in
          "--help")
echo -e "\n usage: ./wus-exiftool.sh --option(s)\n

--print-all-metadata               Print all metadata for a file
--delete-metadata                  Delete all metadata for a specifik file
--delete-all-metadata              Delete all metadata for pictures in dir
--write-artist-2-all               Writes Artist tag to all files in current directory 
--extract-duplicate-tags           Print all meta information in an image, including duplicate and unknown tags
--print-common-all                 Print common meta information for all images in dir.
--print-exposuretune               Print ImageSize and ExposureTime tag names and values.
--print-canon-info                 Print standard Canon information from two image files.
--thumbnailimage                   Save thumbnail image from C to a file called C.
--print-date                       Print formatted date/time for all JPG files in the current directory.
--extract-idf1                     Extract image resolution from EXIF IFD1 information thumbnail image IFD
--extract-resolution               Extract all tags with names containing the word "Resolution" from an image.
--extract-author                   Extract all author-related XMP information from an image.
--extract-gps-postion              Extract all GPS positions from an AVCHD video.
--save-icc                         Save complete ICC_Profile from an image to an output file with the same name and an extension of C.icc
--generate-html                    Generate HTML pages from a hex dump of EXIF information in all images from the C directory. The output HTML files are written to the C directory which is created if it didn't exist, with names of the form FILENAME_EXT.html."
;;
esac

if [ "$1" == "--print-all-metadata" ]; then
exiftool -a -U -G0:4 $2
fi


if [ "$1" == "--delete-metadata" ]; then
exiftool -all= $2; exiftool -XMP:all= $2
fi



if [ "$1" == "--delete-all-metadata" ]; then
exiftool -all= .; exiftool -XMP:all= .
fi



if [ "$1" == "--write-artist-2-all" ]; then
exiftool -artist=wuseman $2 #PATH
fi

if [ "$1" == "--extract-duplicate-tags" ]; then
exiftool -a -u -g1 $2
fi



if [ "$1" == "--print-common-all" ]; then
exiftool -common $2 # PATH
fi



if [ "$1" == "--print-exposuretime" ]; then
exiftool -s -ImageSize -ExposureTime $2
fi 


if [ "$1" == "--print-canon-info" ]; then
exiftool -l -canon c.jpg $2
fi


if [ "$1" == "--thumnailimage" ]; then
exiftool -b -ThumbnailImage Â$2 > $3
fi

if [ "$1" == "--print-date" ]; then
exiftool -d "%r %a, %B %e, %Y" -DateTimeOriginal -S -s $2
fi



if [ "$1" == "--extract-ifd1" ]; then
exiftool -IFD1:XResolution -IFD1:YResolution $2
fi


if [ "$1" == "--extract-resolution" ]; then
exiftool "-*resolution*" $2
fi


if [ "$1" == "--author-related" ]; then
exiftool -xmp:author:all -a $2
fi


if [ "$1" == "--extract-gps-position" ]; then
exiftool -ee -p "$gpslatitude, $gpslongitude, $gpstimestamp" $2
fi


if [ "$1" == "--save-icc" ]; then
exiftool -icc_profile -b -w icc $2
fi


if [ "$1" == "--generate-html" ]; then
exiftool -htmldump -w tmp/%f_%e.html t/images
fi



echo ""
