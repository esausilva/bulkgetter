###################################################################################################
bulkGetter works with an input file and there are four ways you can run it.

Input file contains a list of URLs of the files you want to download, it can also contain the new
name of the files, depending on the options you select. Below is the usage and input file examples.

# Usage: ./bulkGetter.sh inputFile saveToPath [-rs | -rb | -rm] [newFileName]
#  -rs	--rename single file
#  -rb	--rename multiple files
#  -rm	--rename files in bulk with multiple names

1. Running the script without any options will display its usage
	$ ./bulkGetter.sh

2. Run the script with no options if you just want to download a list of files.
	$ ./bulkGetter.sh inputFile.txt /save/to/directory/path

inputFile.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
http://esausilva.com/file1.txt
http://esausilva.com/file2.txt
http://esausilva.com/file3.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


3. Run the script with option '-rs' to download a single file and rename it
	$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rs "New File Name"

inputFile.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
http://esausilva.com/file1.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Will download the file contained in inputFile.txt to 
	/save/to/directory/path/New File Name.txt


4. Run the script with option '-rb' to download a list of files and rename them
	$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rb "New File Name"

inputFile.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
http://esausilva.com/file1.txt
http://esausilva.com/file2.txt
http://esausilva.com/file3.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Will append numbers (1,2,3...) to the downloaded files contained in inputFile.txt
	/save/to/directory/path/New File Name 1.txt
	/save/to/directory/path/New File Name 2.txt
	/save/to/directory/path/New File Name 3.txt
	
This is specially useful when you want to download a bunch of files which are Part1, Part2, etc
You can take this as example: http://librivox.org/ben-hur-a-tale-of-the-christ-by-lew-wallace/
'Ben Hur' audio book has a bunch of books and chapters. Below is the URL example.

http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-01_wallace.mp3
http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-02_wallace.mp3
...
http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-14_wallace.mp3

You would use option '-rb' to download these files and rename them to
	Ben Hur 1-1.mp3, Ben Hur 1-2.mp3, ..., Ben Hur 1-14.mp3

	
5. Run the script with option '-rm' to download a list of files and rename them to different names
	$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rm

Take note, this input file is different, you will need to separate with a semicolon [;] the URL with
the new name of the file

inputFile.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
http://esausilva.com/file1.txt;Another Name
http://esausilva.com/file2.txt;Yet another name
http://esausilva.com/file3.txt;New File Name
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Will download the files contained in inputFile.txt to 
	/save/to/directory/path/Another Name.txt
	/save/to/directory/path/Yet another name.txt
	/save/to/directory/path/New File Name.txt


NOTE 1: As this is run in Linux/Unix console, if your destination directory or your new file name 
contains spaces, you will need to enclose them in "quotation marks"

	$ ./bulkGetter.sh inputFile.txt "/save/to/directory/path with spaces" -rb "New File Name"

NOTE 2: For Proxy Servers and User Agent strings, you can take one from the below links, or just
google "proxy server list" and "user agent strings"

	- http://www.useragentstring.com/pages/useragentstring.php
	- http://proxylist.hidemyass.com/

	
 - jgezau
###################################################################################################