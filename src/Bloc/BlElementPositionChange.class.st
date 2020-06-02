"
I represent a position change and notify a corresponding BlElementPositionChangedEvent
"
Class {
	#name : #BlElementPositionChange,
	#superclass : #BlElementChange,
	#category : #'Bloc-Basic-Changes'
}

{ #category : #notifying }
BlElementPositionChange >> commitChange: anNewValue from: aPreviousValue on: anElement [
	"Notify element event listeners that position within parent has been changed.
	Custom event handlers should subscribe to BlElementPositionChangedEvent"
	
	anElement onPositionChangedFrom: (aPreviousValue ifNil: [ 0@0 ]) to: anNewValue.
	anElement onPositionInSpaceChanged.

	self notifyPositionInSpaceChanged: anElement
]

{ #category : #comparing }
BlElementPositionChange >> compare: aNewValue with: anOldValue [
	"Return true if new value is equal (or close to) to new value"
	<return: #Boolean>

	^ aNewValue closeTo: anOldValue epsilon: self class epsilon
]

{ #category : #accessing }
BlElementPositionChange >> name [
	^ 'Position'
]

{ #category : #notifying }
BlElementPositionChange >> notifyPositionInSpaceChanged: anElement [
	
	anElement children
		select: [ :aChild | aChild changes isPositionChanged not ]
		thenDo: [ :aChild |
			aChild onPositionInSpaceChanged.
			self notifyPositionInSpaceChanged: aChild ]
]
