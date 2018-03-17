layout
isManaged
	self 
		deprecated: 'Use "constraints ignoredByLayout not" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self constraints ignoredByLayout not