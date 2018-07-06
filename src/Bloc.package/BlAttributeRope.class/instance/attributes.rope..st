initialization
attributes: theAttributes rope: aRope

	(theAttributes isKindOf: HashedCollection)
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].

	attributes := self class removeDuplicates: theAttributes.
	rope := aRope