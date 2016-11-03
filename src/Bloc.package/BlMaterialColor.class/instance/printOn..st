as yet unclassified
printOn: aStream
	| name |
	(name := self colorName).
	name ifNotNil: [ 
			^ aStream
				nextPutAll: 'Color ';
				nextPutAll: name ].
	^ super printOn: aStream