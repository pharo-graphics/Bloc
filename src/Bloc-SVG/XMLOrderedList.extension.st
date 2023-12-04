Extension { #name : 'XMLOrderedList' }

{ #category : '*Bloc-SVG' }
XMLOrderedList >> at: anIndex ifPresent: aBlock [
	collection at: anIndex ifAbsent: [ ^self ].
	^aBlock
]
