utilities
mergeAttributes: aCollectionOfAttributes and: anotherCollectionOfAttributes
	"Merge two collection of attributes letting anotherCollectionOfAttributes to override
	attributes from aCollectionOfAttributes based on its type"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	((aCollectionOfAttributes isKindOf: HashedCollection) or: [ anotherCollectionOfAttributes isKindOf: HashedCollection ])
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.

	anotherCollectionOfAttributes reverseDo: [ :each | anOrderedDictionary at: each put: each ].
	aCollectionOfAttributes reverseDo: [ :each | anOrderedDictionary at: each put: each ].

	^ Array streamContents: [ :aStream | anOrderedDictionary keys reverseDo: [ :anObject | aStream nextPut: anObject ] ]