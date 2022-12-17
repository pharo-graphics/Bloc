Class {
	#name : #BlIgnoredLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment',
		'weight'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignCenter [
	alignment := BlElementAlignment horizontal center
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> alignCenterAt: aUnitCoordinateNumber [
	"Align the center of the element vertically with a unit-coordinate inside of the parent"

	alignment := BlHorizontalCoordinateStartAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment horizontal center
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignNone [
	alignment := BlElementAlignment horizontal null
]

{ #category : #alignment }
BlIgnoredLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> alignRightAt: aUnitCoordinateNumber [
	"Align the right of the element horizontally with a unit-coordinate inside of the parent"

	alignment := BlHorizontalCoordinateStartAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment horizontal end
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : #initialization }
BlIgnoredLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment horizontal null.
	weight := 1.0
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> weight [
	<return: #Number>

	^ weight
]

{ #category : #accessing }
BlIgnoredLayoutConstraintsHorizontal >> weight: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight can not be negative' ].

	weight := aNumber
]
