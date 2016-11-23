private - flags testing
isChanged
	^ flags at: #changed ifAbsent: [ false ]