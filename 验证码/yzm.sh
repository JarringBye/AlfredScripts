echo "starting to check code";
 result=$(sqlite3 /Users/kano/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

 name="验证码";

 if [ ! $result ]; then
   echo "latest not receive code messsages";
   osascript -e "display notification \"最近 60 秒未收到验证码！\" with title \"提示\" ";
   return
 fi

 if [[ "$result" =~ "$name" ]]; then
   code=`echo $result | grep -o "[0-9]\{4,6\}"`;
   echo "code is $code";
   echo "$code" | pbcopy;

   osascript -e "display notification \"$code\" with title \"验证码已复制\"";
 fi