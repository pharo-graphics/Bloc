Class {
	#name : #BlBoundsHasChangedDuringScrollingEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlBoundsHasChangedDuringScrollingEvent >> sendTo: anObject [

	anObject boundsHasChangedDuringScrollingEvent: self
]
