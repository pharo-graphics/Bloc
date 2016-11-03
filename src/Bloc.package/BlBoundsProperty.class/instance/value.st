as yet unclassified
value
	isValid
		ifFalse: [ self rawValue: self computeBounds.
			isValid := true ].
	^ self rawValue