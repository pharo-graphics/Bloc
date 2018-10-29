Class {
	#name : #BlGridAlignBoundsMode,
	#superclass : #BlGridAlignmentMode,
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #testing }
BlGridAlignBoundsMode >> isAlignBounds [
	^ true
]

{ #category : #'computing margins' }
BlGridAlignBoundsMode >> marginOf: anChildElement in: aGridLayout isHorizontal: isHorizontal isLeading: isLeading [
	|axis margins spec index |

	axis := aGridLayout axis: isHorizontal.
	margins := isLeading
		ifTrue: [ axis leadingMargins ]
		ifFalse: [ axis trailingMargins ].

	spec := isHorizontal
		ifTrue: [ anChildElement constraints grid horizontal spec ]
		ifFalse: [ anChildElement constraints grid vertical spec ].

	index := isLeading
		ifTrue: [ spec span min ]
		ifFalse: [ spec span max ].

	^ margins at: index + 1
]
