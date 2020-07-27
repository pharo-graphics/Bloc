Class {
	#name : #BlExampleSwitchSkinWithoutTrack,
	#superclass : #BlExampleSwitchLook,
	#instVars : [
		'thumb'
	],
	#category : #'Bloc-Examples-Widgets'
}

{ #category : #accessing }
BlExampleSwitchSkinWithoutTrack >> deactivatedColor [
	^ self color alpha: 0.4
]

{ #category : #initialization }
BlExampleSwitchSkinWithoutTrack >> initializeSkin [
	super initializeSkin.

	widget size: 22@14.
	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 3).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: (BlRoundedRectangleGeometry cornerRadius: 8).

	thumb := self newThumbElement.

	widget addChild: thumb.

	self updateColor
]

{ #category : #'instance creation' }
BlExampleSwitchSkinWithoutTrack >> newThumbElement [
	^ BlElement new
		geometry: (BlEllipse new);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal weight: 0.5.
			c frame horizontal alignRight ]
]

{ #category : #'event handling' }
BlExampleSwitchSkinWithoutTrack >> switchActivated [	
	thumb constraintsDo: [ :c | c frame horizontal alignLeft ].
	thumb background: self color
]

{ #category : #'event handling' }
BlExampleSwitchSkinWithoutTrack >> switchDeactivated [
	thumb constraintsDo: [ :c | c frame horizontal alignRight ].
	thumb background: (self deactivatedColor)
]

{ #category : #updating }
BlExampleSwitchSkinWithoutTrack >> updateColor [
	widget border: (widget border copyWithPaint: self color).

	widget isActivated
		ifTrue: [ thumb background: self color ]
		ifFalse: [ thumb background: self deactivatedColor ]
]
