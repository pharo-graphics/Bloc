as yet unclassified
printOn: aStream
	self name ifNotNil: [ :n | aStream nextPutAll: n ].
	self id ifNotNil: [ :i | aStream nextPutAll: i ].
	self styleClasses
		ifNotEmpty: [ :cls | 
			aStream
				nextPut: $.;
				nextPutAll: (cls joinUsing: '.') ].
	self pseudoClasses
		ifNotEmpty: [ :pcls | 
			aStream
				nextPut: $:;
				nextPutAll: (pcls joinUsing: ':') ]