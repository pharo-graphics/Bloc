instance creation
fromRgbString: aString
	|array|
	array := ( ((aString withoutPrefix: 'rgb(') withoutSuffix: ')') substrings: ',' ) collect: [:stringValue |
		(stringValue endsWith: '%') ifTrue: [(stringValue withoutSuffix: '%') asNumber * 255 / 100 ]
											ifFalse: [stringValue asNumber]].
	
	^self fromRgbTripletOnBase256: array