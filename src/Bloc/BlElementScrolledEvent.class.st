Class {
	#name : #BlElementScrolledEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'delta'
	],
	#category : #'Bloc-Events'
}

{ #category : #'instance creation' }
BlElementScrolledEvent class >> delta: aPoint [
	^ self new
		delta: aPoint;
		yourself
]

{ #category : #accessing }
BlElementScrolledEvent >> delta [
	<return: #Point>

	^ delta
]

{ #category : #accessing }
BlElementScrolledEvent >> delta: aPoint [
	delta := aPoint
]
