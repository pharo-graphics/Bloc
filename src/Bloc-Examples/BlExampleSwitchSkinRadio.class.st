Class {
	#name : #BlExampleSwitchSkinRadio,
	#superclass : #BlExampleSwitchLook,
	#instVars : [
		'thumb'
	],
	#category : #'Bloc-Examples-Widgets'
}

{ #category : #accessing }
BlExampleSwitchSkinRadio >> deactivatedColor [
	^ self color alpha: 0.4
]

{ #category : #initialization }
BlExampleSwitchSkinRadio >> initializeSkin [
	super initializeSkin.

	widget size: 14@14.
	widget layout: BlFrameLayout new.
	widget padding: (BlInsets all: 3).
	widget border: (BlBorder builder width: 1; build).
	widget geometry: BlEllipse new.

	thumb := self newThumbElement.

	widget addChild: thumb.

	self updateColor
]

{ #category : #'instance creation' }
BlExampleSwitchSkinRadio >> newThumbElement [
	^ BlElement new
		geometry: BlEllipse new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'event handling' }
BlExampleSwitchSkinRadio >> switchActivated [

	thumb background: self color
]

{ #category : #'event handling' }
BlExampleSwitchSkinRadio >> switchDeactivated [
	thumb background: self deactivatedColor
]

{ #category : #updating }
BlExampleSwitchSkinRadio >> updateColor [
	widget border: (widget border copyWithPaint: self color).

	widget isActivated
		ifTrue: [ thumb background: self color ]
		ifFalse: [ thumb background: self deactivatedColor ]
]
