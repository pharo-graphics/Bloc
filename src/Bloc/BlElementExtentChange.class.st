"
I represent an extent change and notify a corresponding BlElementExtentChangedEvent
"
Class {
	#name : #BlElementExtentChange,
	#superclass : #BlElementChange,
	#category : #'Bloc-Basic-Changes'
}

{ #category : #notifying }
BlElementExtentChange >> commitChange: anNewValue from: aPreviousValue on: anElement [
	"Notify element event listeners that element's extent changed.
	Custom event handlers should subscribe to BlElementExtentChangedEvent"

	anElement telemetry
		timeSync: [ 'onExtentChanged ', anElement class name ]
		during: [ anElement onExtentChanged ]
]

{ #category : #comparing }
BlElementExtentChange >> compare: aNewValue with: anOldValue [
	"Return true if new value is equal (or close to) to new value"
	<return: #Boolean>
	
	^ aNewValue closeTo: anOldValue epsilon: self class epsilon
]

{ #category : #accessing }
BlElementExtentChange >> name [
	^ 'Extent'
]
