Class {
	#name : #BlInfiniteScrollChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'scrollState'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteScrollChangedEvent class >> scrollState: aScrollState [

	^ self new
		scrollState: aScrollState;
		yourself
]

{ #category : #accessing }
BlInfiniteScrollChangedEvent >> scrollState [
	^ scrollState
]

{ #category : #accessing }
BlInfiniteScrollChangedEvent >> scrollState: anObject [
	scrollState := anObject
]
