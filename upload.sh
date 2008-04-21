# Usage:
#  upload.sh user@host localFile remoteDir
#
# To Do:
# * support multiple files
# * support directory transfers

scp $2 $1:./temp
ssh $1 "sudo mv ./temp $3"
