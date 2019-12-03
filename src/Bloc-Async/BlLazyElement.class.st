"
BlLazyElement lazily renders its child element deferring the rendering until the element actually becomes visible in the window.  E.g. if the window can be scrolled and the element is not visible, no action is taken.


Public API and Key Messages

- elementBuilder:   a valuable, typically a BlockClosure, that returns the child element

[[[
BlLazyElement new elementBuilder:
	[ BlTextElement new 
		text: 'hello world' asRopedText;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ] ];
	constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ]
]]]
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	element:				<BlElement>
	elementBuilder:		<BlockClosure>


"
Class {
	#name : #BlLazyElement,
	#superclass : #BlAsyncElement,
	#instVars : [
		'elementBuilder',
		'element'
	],
	#category : #'Bloc-Async'
}

{ #category : #controlling }
BlLazyElement class >> ifEnabledInstanceDo: anInstanceBlock elementBuilder: anElementBuilder [
	^ self 
		ifEnabledInstanceDo: [ :theLazyElement | 
			anInstanceBlock value: theLazyElement.
			theLazyElement elementBuilder: anElementBuilder ]
		otherwise: [ 
			| anElement |
			anElement := BlElement new.
			anInstanceBlock value: anElement.
			anElement
				removeChildren;
				addChild: anElementBuilder value ]
]

{ #category : #ui }
BlLazyElement >> buildElement [
	"Build the element and display it"

	self 
		assert: [ elementBuilder isNotNil ]
		description: [ 'No element builder has been set' ].
	self element: elementBuilder value.

]

{ #category : #drawing }
BlLazyElement >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.
	element ifNil: [ self queueAsyncUpdate ].
]

{ #category : #accessing }
BlLazyElement >> element [
	^ element
]

{ #category : #accessing }
BlLazyElement >> element: aBlElement [
	"Set the receiver's element.
	If not nil, add it as a child"

	element := aBlElement.
	element ifNotNil:[ 
		self enqueueTask: (BlTaskAction new action: [ 
			self 
				removeChildren;
				addChild: element;
				invalidate ]) ]

]

{ #category : #accessing }
BlLazyElement >> elementBuilder [
	^ elementBuilder
]

{ #category : #accessing }
BlLazyElement >> elementBuilder: anObject [
	elementBuilder := anObject
]

{ #category : #testing }
BlLazyElement >> needsUpdate [
	"Answer a boolean indicating whether the receiver needs to be udpated"

	^super needsUpdate and: [ element isNil ].

]

{ #category : #'async processing' }
BlLazyElement >> queueEntry [
	"Answer a TaskIt valuable that will update the receiver."

	^(BlTktUnresponsiveCommand new 
		valuable: (BlLazyElementValuable element: self);
		name: 'BlLazyElement(', elementBuilder printString, ')';
		yourself) asBlTktLoggingCommand asBlTktSingleCommand
			identifier: self.


]

{ #category : #'async processing' }
BlLazyElement >> taskPool [
	^ BlTktWorkerProvider highUICPUBoundPool 
]
