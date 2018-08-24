Class {
	#name : #BlElementScrolledEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'delta'
	],
	#category : 'Bloc-Event'
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
