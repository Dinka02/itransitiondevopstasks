
#!/bin/bash
mkdir my_new_dir
cd my_new_dir

cp ~/my_file.txt /tmp/


rm ~/my_file.txt

ls~/

#1.7
echo "Input your File: "
read filename
if [ -f "$filename" ]; then
 cat "$filename"
else
  echo "File does not exist"
fi

#1.8
echo "Input your Folder: "
read directory
if [ -f "$directory" ]; then
 cat "$directory" 
else 
  echo "Catalog  does not exist" 
fi 
 

#1.9
echo "Input your file"
read  filename
if [ -f "$filename"]; then
cat "$filename"
else
echo "File doesn't exist"
fi

#1.10
echo "Input your Directory: "
read directory
if [ -f "$directory" ]; then
 cat "$directory" 
else 
  echo "Directory  does not exist" 
fi 


#1.11
echo "Input your Files:"
read filename
if [-f "$filename"]; then
sed -i 's/error/warning/g' "$filename"
echo "Replacement completed"
else 
echo "File doesn't exist"
fi

#1.12
pattern="error"
directory="/var/log"
found_files=$(grep -r1 "$pattern" "$directory" )
if [ -n "$found_files"]; then
echo "Files counting found \ "$pattern\":"
echo "$found_files"
else 
echo "Files doesn't found"
fi 


#1.13
df -h 







