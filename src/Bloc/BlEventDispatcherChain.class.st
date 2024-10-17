"
I am a chain of BlEventDispatchers

"
Class {
	#name : #BlEventDispatcherChain,
	#superclass : #Object,
	#instVars : [
		'previous',
		'dispatcher'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #'instance creation' }
BlEventDispatcherChain class >> empty [
	
	^ BlEventDispatcherEmptyChain uniqueInstance
]

{ #category : #'instance creation' }
BlEventDispatcherChain class >> with: aBlEventDispatcher [

	^ self new
		  initializeWith: aBlEventDispatcher;
		  yourself
]

{ #category : #'api - event managing' }
BlEventDispatcherChain >> dispatchEvent: anEvent [
	"Dispatch a given event through the whole dispatcher chain"

	| aPreviousChain |
	aPreviousChain := self hasPrevious
		ifTrue: [ self previous ]
		ifFalse: [ self class empty ].

	^ self dispatcher dispatchEvent: anEvent next: aPreviousChain
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> dispatcher [
	
	^ dispatcher
]

{ #category : #'api - accessing' }
BlEventDispatcherChain >> first [

	^ self hasPrevious
		ifTrue: [ self previous first ]
		ifFalse: [ self ]
]

{ #category : #'private - testing' }
BlEventDispatcherChain >> hasDispatcher [
	
	^ dispatcher isNotNil
]

{ #category : #'private - testing' }
BlEventDispatcherChain >> hasPrevious [
	
	^ previous isNotNil
]

{ #category : #initialization }
BlEventDispatcherChain >> initializeWith: aBlEventDispatcher [

	self initialize.
	dispatcher := aBlEventDispatcher
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> previous [

	^ previous
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> previous: aBlEventDispatcherChain [

	previous := aBlEventDispatcherChain
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> withAllPrevious [
	"Answer a `SequenceableCollection` of `BlEventDispatcherChain`"

	^ Array streamContents: [ :aStream |
		| aChain |
		aChain := self.
		aStream nextPut: aChain.
		[ aChain hasPrevious ] whileTrue: [
			aStream nextPut: aChain previous.
			aChain := aChain previous ] ]
]

{ #category : #'api - adding' }
BlEventDispatcherChain >> withNext: aBlEventDispatcher [

	| aNextChain |
	aNextChain := self class with: aBlEventDispatcher.
	aNextChain previous: self.

	^ aNextChain
]
