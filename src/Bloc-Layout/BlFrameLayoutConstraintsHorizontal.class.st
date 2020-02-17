Class {
	#name : #BlFrameLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment',
		'weight'
	],
	#category : #'Bloc-Layout-Frame'
}

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignCenter [
	"I align the center of the child element horizontally with the center of the parent"

	alignment := BlElementAlignment horizontal center
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignCenterAt: aUnitCoordinateNumber [
	"Align the center of the element horizontally with a unit-coordinate inside of the parent"

	alignment := BlHorizontalCoordinateStartAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment horizontal center
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignLeftAt: aUnitCoordinateNumber [
	"Align the left of the element horizontally with a unit-coordinate inside of the parent"

	alignment := BlHorizontalCoordinateStartAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment horizontal start
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignRightAt: aUnitCoordinateNumber [
	"Align the right of the element horizontally with a unit-coordinate inside of the parent"

	alignment := BlHorizontalCoordinateStartAlignment new
		coordinate: aUnitCoordinateNumber;
		relativeAlignment: BlElementAlignment horizontal end
]

{ #category : #accessing }
BlFrameLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : #alignment }
BlFrameLayoutConstraintsHorizontal >> alignment: aBlElementAlignment [
	alignment := aBlElementAlignment
]

{ #category : #initialization }
BlFrameLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment horizontal null.
	weight := 1.0
]

{ #category : #accessing }
BlFrameLayoutConstraintsHorizontal >> weight [
	<return: #Number>

	^ weight
]

{ #category : #accessing }
BlFrameLayoutConstraintsHorizontal >> weight: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight can not be negative' ].

	weight := aNumber
]
