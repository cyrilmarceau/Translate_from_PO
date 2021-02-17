#! /bin/bash
echo "{" > translate.json
	while read line;
		do
			echo -n "$line" | grep "msgid" | sed "s/msgid //" | sed 's/$/:/' | tr -d '\n' >> translate.json
			echo -n "$line" | grep "msgstr" | sed "s/msgstr //" | sed 's/$/,/' >> translate.json
		done < translate.po
	
	sed -zr -i 's/,([^,]*$)/\1/' translate.json
echo "}" >> translate.json

cat translate.json