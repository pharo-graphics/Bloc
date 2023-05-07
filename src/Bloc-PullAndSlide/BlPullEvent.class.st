Class {
	#name : #BlPullEvent,
	#superclass : #BlEvent,
	#instVars : [
		'initialPosition',
		'oldPosition',
		'newPosition',
		'delta'
	],
	#category : #'Bloc-PullAndSlide-Events'
}

{ #category : #accessing }
BlPullEvent >> absoluteDelta [
	^ self newPosition - self initialPosition
]

{ #category : #accessing }
BlPullEvent >> delta [
	^ delta
]

{ #category : #accessing }
BlPullEvent >> delta: anObject [
	delta := anObject
]

{ #category : #accessing }
BlPullEvent >> initialPosition [
	^ initialPosition
]

{ #category : #accessing }
BlPullEvent >> initialPosition: anObject [
	initialPosition := anObject
]

{ #category : #accessing }
BlPullEvent >> newPosition [
	^ newPosition
]

{ #category : #accessing }
BlPullEvent >> newPosition: anObject [
	newPosition := anObject
]

{ #category : #accessing }
BlPullEvent >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
BlPullEvent >> oldPosition: anObject [
	oldPosition := anObject
]
