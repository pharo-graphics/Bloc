as yet unclassified
read: anObject
	^ (anObject instVarAt: index) ifNil: [ self instantiateIn: anObject ].
	
	