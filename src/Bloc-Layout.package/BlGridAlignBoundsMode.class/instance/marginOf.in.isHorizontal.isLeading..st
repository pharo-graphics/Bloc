computing margins
marginOf: anChildElement in: aGridLayout isHorizontal: isHorizontal isLeading: isLeading
	|axis margins spec index |

	axis := aGridLayout axis: isHorizontal.
	margins := isLeading
		ifTrue: [ axis leadingMargins ]
		ifFalse: [ axis trailingMargins ].

	spec := isHorizontal
		ifTrue: [ anChildElement constraints grid horizontal spec ]
		ifFalse: [ anChildElement constraints grid vertical spec ].

	index := isLeading
		ifTrue: [ spec span first ]
		ifFalse: [ spec span last ].

	^ margins at: index