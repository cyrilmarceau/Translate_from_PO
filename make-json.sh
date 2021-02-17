#! /bin/bash
language=$(cat translate.po | grep 'Language:'  | sed "s/Language: //" | sed -e 's/^"//' -e 's/"$//' | sed 's/\\/ /g' | tr -d ‘\n’ | xargs) 
echo $language
echo "{" > "translate-${language}.json"
	while read line;
		do
			echo -n "$line" | grep "msgid" | sed "s/msgid //" | sed 's/$/:/' | tr -d '\n' >> "translate-${language}.json"
			echo -n "$line" | grep "msgstr" | sed "s/msgstr //" | sed 's/$/,/' >> "translate-${language}.json"
		done < translate.po
	
	sed -zr -i 's/,([^,]*$)/\1/' "translate-${language}.json"
echo "}" >> "translate-${language}.json"