initialization
rope: aRope offset: anOffset length: aLength

	anOffset < 0
		ifTrue: [ self error: 'Negative offset: ', anOffset asString ].
	aLength < 0
		ifTrue: [ self error: 'Negative length: ', aLength asString ].
	(aLength + anOffset) > aRope size
		ifTrue: [ self error: 'Illegal offset (', anOffset asString,') and length (',aLength asString,') combination for sub rope of length ', aRope size asString ].

	rope := aRope.
	offset := anOffset.
	length := aLength