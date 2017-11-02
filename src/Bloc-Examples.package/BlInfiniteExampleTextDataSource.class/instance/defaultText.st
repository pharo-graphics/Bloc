initialization
defaultText
	| aText |
	aText := SpText fromString: (String loremIpsum: 1000000).
	^ aText