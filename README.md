# bulkgetter

> Basically bulkGetter functions as a downloading command line tool accepting an input file as a feed with the desired link(s) to download. It can download files, save them to a specified location, rename them and it also supports resuming downloads.

## Usage 

Input file contains a list of URLs of the files you want to download, it can also contain the new
name of the files, depending on the options you select. 

Below is the usage and input file examples.

``` bash
$ ./bulkGetter.sh inputFile.txt /save/to/directory/path [-rs | -rb | -rm] [newFileName]
```

|Option|Description|
|---|---|
|-rs|rename single file|
|-rb|rename multiple files|
|-rm|rename files in bulk with multiple names|

### Proxy Server

`bulkGetter-0.02.sh` supports the usage of proxy servers. Lines 37 and 37 of the shell script should be used.

``` bash
userAgent="[ADD HERE YOUR USER AGENT STRING]"    # read "NOTE 2" in readme.txt
proxyServer="[ADD HERE A PROXY SERVER ADDRESS]"  # read "NOTE 2" in readme.txt
```

## Examples

### Example 1

Running the script without any options will display its usage

``` bash
$ ./bulkGetter.sh
```

### Example 2

Run the script with no options if you just want to download a list of files.

``` bash
$ ./bulkGetter.sh inputFile.txt /save/to/directory/path
```

`inputFile.txt` contents

``` txt
http://esausilva.com/file1.txt
http://esausilva.com/file2.txt
http://esausilva.com/file3.txt
```

### Example 3

Run the script with option `-rs` to download a single file and rename it

``` bash
$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rs "New File Name"
```

`inputFile.txt` contents

``` text
http://esausilva.com/file1.txt
```

Will download the file contained in `inputFile.txt` to `/save/to/directory/path/New File Name.txt`

### Example 4

Run the script with option `-rb` to download a list of files and rename them

``` bash
$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rb "New File Name"
```

`inputFile.txt` contents

``` text
http://esausilva.com/file1.txt
http://esausilva.com/file2.txt
http://esausilva.com/file3.txt
```

This option will append numbers (1,2,3...) to the downloaded files contained in `inputFile.txt`

``` text
/save/to/directory/path/New File Name 1.txt
/save/to/directory/path/New File Name 2.txt
/save/to/directory/path/New File Name 3.txt
```
	

This is specially useful when you want to download a bunch of files which are Part1, Part2, etc
You can take this as example: [*Ben Hur*](http://librivox.org/ben-hur-a-tale-of-the-christ-by-lew-wallace/) audio book has a bunch of books and chapters. 

Below is the URL example.

``` text
http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-01_wallace.mp3
http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-02_wallace.mp3
...
http://www.archive.org/download/benhur_0906_librivox/ben-hur_1-14_wallace.mp3
```

You would use option `-rb` to download these files and rename them to `Ben Hur 1-1.mp3, Ben Hur 1-2.mp3, ..., Ben Hur 1-14.mp3`

### Example 5
	
Run the script with option `-rm` to download a list of files and rename them to different names

``` bash
$ ./bulkGetter.sh inputFile.txt /save/to/directory/path -rm
```

__Take note__, this input file is different, you will need to separate with a semicolon [;] the URL with the new name of the file

`inputFile.txt` contents

``` text
http://esausilva.com/file1.txt;Another Name
http://esausilva.com/file2.txt;Yet another name
http://esausilva.com/file3.txt;New File Name
```

Will download the files contained in inputFile.txt to 

``` text
/save/to/directory/path/Another Name.txt
/save/to/directory/path/Yet another name.txt
/save/to/directory/path/New File Name.txt
```

## Other Notes

**NOTE 1:** As this is run in Linux/Unix console, if your destination directory or your new file name 
contains spaces, you will need to enclose them in "quotation marks"

``` bash
$ ./bulkGetter.sh inputFile.txt "/save/to/directory/path with spaces" -rb "New File Name"
```

**NOTE 2:** For Proxy Servers and User Agent strings, you can take one from the below links, or just
google "proxy server list" and "user agent strings"

 * [User Agent Strings](http://www.useragentstring.com/pages/useragentstring.php)
 * [Proxy Server List](http://proxylist.hidemyass.com/)

**NOTE 3:** This shell script uses [wget](https://en.wikipedia.org/wiki/Wget) utility, if your system does not have it, I have included it in this repo.
	
-Esau
