Class {
	#name : #BlGestureScrollEvent,
	#superclass : #BlGestureBaseScrollEvent,
	#instVars : [
		'vector'
	],
	#category : #'Bloc-Event'
}

{ #category : #sending }
BlGestureScrollEvent >> sendTo: anObject [
	anObject gestureScrollEvent: self
]

{ #category : #accessing }
BlGestureScrollEvent >> vector [
	<return: #BlVector>

	^ vector
]

{ #category : #accessing }
BlGestureScrollEvent >> vector: aBlVector [
	vector := aBlVector
]
