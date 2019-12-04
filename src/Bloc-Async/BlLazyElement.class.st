"
BlLazyElement lazily renders its child element deferring the rendering until the element actually becomes visible in the window.  E.g. if the window can be scrolled and the element is not visible, no action is taken.

!! Async Example 

The lazy element starts with the following temporary content:
${example:BlAsyncElementExamples>>#temporaryElement|noCode|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=80}$

And ends-up with the following final content:
${example:BlAsyncElementExamples>>#finalElement|noCode|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=80}$

Executing the following example shows the lazy element that at quickly change the content computed in the bacground:
${example:BlAsyncElementExamples>>#lazyElement|previewExpanded=false|previewShow=#gtLiveFor:|previewHeight=80}$

!! Sync Example

In particular cases, in which the lazy rendering needs to be disabled, ${class:BlUseAsyncFeatures}$ can be used as shown in the following example
${example:BlAsyncElementExamples>>#syncLazyElement|previewExpanded=false|previewShow=#gtLiveFor:|previewHeight=80}$

!! Public API and Key Messages

- elementBuilder:   a valuable, typically a BlockClosure, that returns the child element
 
!! Internal Representation and Key Implementation Points.

!!! Instance Variables
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

{ #category : #ui }
BlLazyElement >> buildElement [
	"Build the element and display it"

	self 
		assert: [ elementBuilder isNotNil ]
		description: [ 'No element builder has been set' ].
	self element: elementBuilder value.

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
	element ifNotNil: [
		| anAction |
		anAction := [ self 
			removeChildren;
			addChild: element;
			invalidate ].
		BlUseAsyncFeatures 
			ifEnabledDo: [ 
				self enqueueTask: (BlTaskAction new action: anAction) ]
			otherwise: anAction ]

]

{ #category : #accessing }
BlLazyElement >> elementBuilder [
	^ elementBuilder
]

{ #category : #accessing }
BlLazyElement >> elementBuilder: anObject [
	elementBuilder := anObject.
	BlUseAsyncFeatures ifDisabledDo: [ self buildElement ].
]

{ #category : #'async processing' }
BlLazyElement >> mayQueueAsyncUpdate [
	(self element isNil and: [ self isVisibleInSpace ]) ifFalse: [ ^ self ].
	self queueAsyncUpdate
]

{ #category : #testing }
BlLazyElement >> needsUpdate [
	"Answer a boolean indicating whether the receiver needs to be updated"

	^super needsUpdate and: [ element isNil ].

]

{ #category : #'hooks - children' }
BlLazyElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self mayQueueAsyncUpdate.

]

{ #category : #'hooks - geometry' }
BlLazyElement >> onExtentChanged [
	super onExtentChanged.
	self mayQueueAsyncUpdate.

]

{ #category : #'hooks - geometry' }
BlLazyElement >> onPositionInSpaceChanged [
	super onPositionInSpaceChanged.
	self mayQueueAsyncUpdate.
]

{ #category : #'hooks - geometry' }
BlLazyElement >> onTransformationInSpaceChanged [
	super onTransformationInSpaceChanged.
	self mayQueueAsyncUpdate.

]

{ #category : #'async processing' }
BlLazyElement >> queueEntry [
	"Answer a TaskIt valuable that will update the receiver."

	^ ((BlTktUnresponsiveCommand new 
			valuable: (BlLazyElementValuable element: self);
			name: 'BlLazyElement(', elementBuilder printString, ')';
			yourself) asBlTktSingleCommand
				identifier: self) asBlTktLoggingCommand


]

{ #category : #'async processing' }
BlLazyElement >> taskPool [
	^ BlTktWorkerProvider highUICPUBoundPool 
]
