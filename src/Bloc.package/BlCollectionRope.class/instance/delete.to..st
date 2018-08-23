rope - deleting
delete: aStart to: anEnd
	| newCollection |
	self assertAccessFrom: aStart to: anEnd.
	
	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self ].
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self empty ].
	
	newCollection := Array new: collection size - (anEnd - aStart + 1).
	
	aStart > 1 ifTrue: [ 
			newCollection
				replaceFrom: 1 to: aStart - 1
				with: collection
				startingAt: 1 ].
			
	anEnd < self size ifTrue: [ 
			newCollection
				replaceFrom: aStart to: newCollection size
				with: collection
				startingAt: anEnd + 1 ].
			
	^ self class collection: newCollection