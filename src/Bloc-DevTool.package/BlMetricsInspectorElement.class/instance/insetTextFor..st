instance creation
insetTextFor: aNumber

	^ aNumber isZero
		ifTrue: [ BrRopedText string: '-' ]
		ifFalse: [ BrRopedText string: aNumber asString ]