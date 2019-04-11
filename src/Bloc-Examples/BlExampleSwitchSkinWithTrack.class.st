Class {
	#name : #BlExampleSwitchSkinWithTrack,
	#superclass : #BlExampleSwitchLook,
	#instVars : [
		'track',
		'thumb',
		'cornerRadius'
	],
	#category : #'Bloc-Examples-Widgets'
}

{ #category : #accessing }
BlExampleSwitchSkinWithTrack >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
BlExampleSwitchSkinWithTrack >> cornerRadius: aNumber [
	cornerRadius := aNumber.
	
	widget ifNil: [ ^ self ].
	self updateCornerRadius.
]

{ #category : #initialization }
BlExampleSwitchSkinWithTrack >> initialize [
	super initialize.
	
	cornerRadius := 0
]

{ #category : #initialization }
BlExampleSwitchSkinWithTrack >> initializeSkin [
	super initializeSkin.

	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 4).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: (BlRectangle new).

	widget size: 36@14.

	thumb := self newThumbElement.
	track := self newTrackElement.

	widget addChildren: { track . thumb }.
	
	self updateColor.
	self updateCornerRadius
]

{ #category : #'instance creation' }
BlExampleSwitchSkinWithTrack >> newThumbElement [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal weight: 0.5.
			c frame horizontal alignRight ]
]

{ #category : #'instance creation' }
BlExampleSwitchSkinWithTrack >> newTrackElement [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'event handling' }
BlExampleSwitchSkinWithTrack >> switchActivated [	
	thumb constraintsDo: [ :c | c frame horizontal alignLeft ]
]

{ #category : #'event handling' }
BlExampleSwitchSkinWithTrack >> switchDeactivated [
	thumb constraintsDo: [ :c | c frame horizontal alignRight ]
]

{ #category : #updating }
BlExampleSwitchSkinWithTrack >> updateColor [
	widget border: (widget border copyWithPaint: self color).
	thumb background: self color.
	track background: (self color alpha: 0.3)
]

{ #category : #updating }
BlExampleSwitchSkinWithTrack >> updateCornerRadius [
	widget geometry: (BlRectangle cornerRadius: self cornerRadius)
]
