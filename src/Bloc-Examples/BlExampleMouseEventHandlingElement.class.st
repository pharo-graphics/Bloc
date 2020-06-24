Class {
	#name : #BlExampleMouseEventHandlingElement,
	#superclass : #BlElement,
	#instVars : [
		'clickCount'
	],
	#category : #'Bloc-Examples-Event'
}

{ #category : #accessing }
BlExampleMouseEventHandlingElement >> clickCount [
	^ clickCount
]

{ #category : #accessing }
BlExampleMouseEventHandlingElement >> clickCount: anObject [
	clickCount := anObject
]

{ #category : #accessing }
BlExampleMouseEventHandlingElement >> incrementClickCount [
	clickCount := clickCount + 1
]

{ #category : #initialization }
BlExampleMouseEventHandlingElement >> initialize [
	super initialize.
	
	clickCount := 0.
	
	self when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementClickCount ].
	
	self addEventHandler: BlPullHandler new.
	
	self background: Color veryVeryLightGray
]
