text - converting
asString
	
	^ String streamContents: [ :aStream |
		| anIterator |
		anIterator := self iterator.
		[ anIterator hasNext ] whileTrue: [ 
			aStream nextPutAll: anIterator next asString ] ]
	