accessing
size
	<return: #Number>

	^ scrap
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :aDictionary | aDictionary sum: [ :each | each size ] ]