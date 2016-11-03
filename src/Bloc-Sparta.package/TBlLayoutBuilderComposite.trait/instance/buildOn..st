builder
buildOn: anElement
	| elements |
	elements := self asCollection collect: [ :each | 
		((each at: self class floatLeft) size + (each at: self class floatRight) size) isZero
			ifTrue: [ each at: self class floatNone ifAbsent: [ nil ] ]
			ifFalse: [ 
				| element |
				element := BlElement new.
				"element background: Color blue."
				element layout: BlLinearLayout horizontal.
				element constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
				element addChildren: (each at: self class floatLeft).
				each at: self class floatNone ifPresent: [ :el | element addChild: el ].
				element addChildren: (each at: self class floatRight) reversed.
				element ] ].
	anElement addChildren: (elements select: #isNotNil)