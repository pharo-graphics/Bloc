utilities
removeDuplicates: aCollection
	"Remove duplicates from a given collection preserving the original order"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	(aCollection isKindOf: HashedCollection)
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.
	aCollection reverseDo: [ :each | anOrderedDictionary at: each put: each ].

	^ Array streamContents: [ :aStream | anOrderedDictionary keys reverseDo: [ :anObject | aStream nextPut: anObject ] ]