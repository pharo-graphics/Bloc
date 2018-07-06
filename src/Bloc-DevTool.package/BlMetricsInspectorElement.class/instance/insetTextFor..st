instance creation
insetTextFor: aNumber

	^ aNumber isZero
		ifTrue: [ BlRopedText string: '-' ]
		ifFalse: [ BlRopedText string: aNumber asString ]