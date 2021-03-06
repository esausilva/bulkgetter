#!/bin/bash
########################################################################################################
# Simple script that uses wget to retreive internet files from a given input file. The script has four
# options that accept three different type of input files depending if you want to rename the downloaded
# files or not. Refer to 'readme.txt' for more usage information.
#
# Author: Esau Silva (jgezau)
# Version: 0.02
#
# wget used options
# -t0						--unlimited number of tries
# -c						--resume broken downloads
# -np						--do not ascend to the parent directory
# -P						--save files to a specific directory
# -O						--rename the downloded file
# --execute=http_proxy=		--hides wget behind a proxy server
# --user-agent=				--mask user agent and display wget like browser
#
# ** Change History **
# User		Date		Description
# jgezau	20121020	Initial coding
# jgezau	20121030	Added wrapping quotation marks ("") to saveTo when creating directory
# jgezau	20121219	Added "-p" to make directory structure that is several directories deep
# jgezau	20130110	Changed IFS from ',' to ';'
# jgezau	20130323	Added public proxy server support w/o password
#						Added user agent support to mask wget like a browser
#						Added 5 sec delay between each download when -rb or -rm is used
# jgezau	20130810	Print to terminal number of files to download and file number currently
#						downloading
########################################################################################################

# Variables
inFile=$1
saveTo=$2
renameOption=$3
newFileName=$4
userAgent=""	# read "NOTE 2" in readme.txt
proxyServer=""	# read "NOTE 2" in readme.txt
sleeping=5

# Flags
good2go=0
changeIFS=0
noRename=0
rename=0

# Displays usage when script is ran w/o arguments
if [[ $# -eq 0 ]]; then
	echo -e "\t Usage: ./bulkGetter.sh inputFile saveToPath [-rs | -rb | -rm] [newFileName]"
	echo -e "\t	-rs	--rename single file"
	echo -e "\t	-rb	--rename files in bulk"
	echo -e "\t	-rm	--rename files in bulk with multiple names"
	exit
fi

# Check if input file exists
if [[ ! -f $inFile ]]; then
	echo -e "\t '$inFile' does not exist"
	echo -e "\t Now exiting script"
	exit
fi

# Check for correct arguments
if [[ $# -eq 4 ]]; then
	if [[ $renameOption != "-rs" && $renameOption != "-rb" ]]; then
		echo -e "\tArgument three needs to be '-rs', '-rb' or '-rm'"
		echo -e "\tRun script w/o arguments for usage information...Now exiting script"
		exit 1
	fi
	good2go=1
	rename=1
elif [[ $# -eq 2 ]]; then
	good2go=1
	noRename=1
elif [[ $# -eq 3 ]]; then
	if [[ $renameOption == "-rm" ]]; then
		changeIFS=1
		good2go=1
		rename=1
	else
		echo -e "\tYou need one more argument."
		echo -e "\tRun script w/o arguments for usage information...Now exiting script"
		exit 1
	fi
elif [[ $# -gt 4 || $# -eq 1 ]]; then
	echo -e "\tbulkGetter accepts either 2 or 4 arguments."
	echo -e "\tRun script w/o arguments for usage information...Now exiting script"
	exit 1
fi

# Perform bulkGetter's job
if [[ $good2go -eq 1 ]]; then
	
	# If destination directory does not exists, create it
	if [[ ! -d "$saveTo" ]]; then
		mkdir -p "$saveTo"
	fi

	# Initialize the counter
	filesToDownload=$(cat $inFile | wc -l)
	echo "Downloading $filesToDownload files"

	# No Rename Files
	if [[ $noRename -eq 1 ]]; then
		for url in $(cat $inFile); do
			wget -t10 -c -np --execute=http_proxy="$proxyServer" -P "$saveTo" --user-agent="${userAgent}" "$url"
		done
	
	# Rename Files
	elif [[ $rename -eq 1 ]]; then 
		
		# Rename single file
		if [[ $renameOption == "-rs" ]]; then
			url=$(cat $inFile)
			fileExt=$(echo "$url" | awk -F. '{if (NF>1) {print $NF}}')
			wget -t10 -c -np --execute=http_proxy="$proxyServer" -O "${saveTo}/${newFileName}.${fileExt}" --user-agent="$userAgent" "$url"
		
		# Rename files in bulk   
		elif [[ $renameOption == "-rb" ]]; then
			part=1
			for url in $(cat $inFile); do
				echo "Counter: $part of $filesToDownload"
				fileExt=$(echo "$url" | awk -F. '{if (NF>1) {print $NF}}')
				wget -t10 -c -np --execute=http_proxy="$proxyServer" -O "${saveTo}/${newFileName} ${part}.${fileExt}" --user-agent="${userAgent}" "$url"
				sleep $sleeping
				(( part++ ))
			done
		
		# Rename files in bulk with multiple names
		elif [[ $renameOption == "-rm" ]]; then
			
			# Change IFS to ';'
			OLDIFS=$IFS
			IFS=';'
			
			inOneLiner=$(cat $inFile | sed 's:$:;:' | tr -d '\n' | sed 's:;$::')

			# Adding URL and New FileName to an array
			count=1
			for line in $inOneLiner; do
				isOdd=$(( $count % 2 ))
				if [[ $isOdd -eq 1 ]]; then
					url[$count]=$line
				else
					file[$count]=$line
				fi
				(( count++ ))
			done
			
			# Change IFS back to default
			IFS=$OLDIFS

			count2=1
			for (( i = 1; i < $count; i++ )); do
				echo "Counter: $count2 of $filesToDownload"
				fileExt=$(echo "${url[$i]}" | awk -F. '{if (NF>1) {print $NF}}')
				wget -t10 -c -np --execute=http_proxy="$proxyServer" -O "${saveTo}/${file[$i+1]}.${fileExt}" --user-agent="${userAgent}" "${url[$i]}"
				sleep $sleeping
				(( count2++ ))
				(( i++ ))
			done
		fi
	fi
fi
