"
Sent when an element is detached from InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: OBlInfiniteElementDetachedEvent
	do: [ :event | self inform: 'Detached: ', event element asString ]

"
Class {
	#name : #BlInfiniteElementDetachedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #'instance creation' }
BlInfiniteElementDetachedEvent class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
BlInfiniteElementDetachedEvent >> element [
	^ element
]

{ #category : #accessing }
BlInfiniteElementDetachedEvent >> element: anObject [
	element := anObject
]

{ #category : #sending }
BlInfiniteElementDetachedEvent >> sendTo: anObject [

	anObject infiniteElementDetachedEvent: self
]
