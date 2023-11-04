"
Sent when an element is attached to InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: OBlInfiniteElementAttachedEvent
	do: [ :event | self inform: 'Atatched:  ', event element asString ]

"
Class {
	#name : 'BlInfiniteElementAttachedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'element'
	],
	#category : 'Bloc-Infinite-Events',
	#package : 'Bloc-Infinite',
	#tag : 'Events'
}

{ #category : 'instance creation' }
BlInfiniteElementAttachedEvent class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : 'accessing' }
BlInfiniteElementAttachedEvent >> element [
	^ element
]

{ #category : 'accessing' }
BlInfiniteElementAttachedEvent >> element: anObject [
	element := anObject
]
