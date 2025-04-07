"
I log all key press events and allow users to detect what keys are pressed at any time.

I allow `=BlKeyboardProcessor`= to sent key still pressed event every frame if there is at least one pressed key

"
Class {
	#name : #BlKeyboardBuffer,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'adding / removing' }
BlKeyboardBuffer >> add: anEvent [

	events at: anEvent key put: anEvent
]

{ #category : #accessing }
BlKeyboardBuffer >> eventAt: aKey [
	"Answer a `BlKeyDownEvent` that corresponds to aKey"
	
	^ events at: aKey
]

{ #category : #accessing }
BlKeyboardBuffer >> events [
	"Answer my collection of `BlKeyDownEvent`s"

	^ events values
]

{ #category : #testing }
BlKeyboardBuffer >> hasEvent: aKey [
	"Return true if there is a buffered event for a given key"
	
	^ events includesKey: aKey
]

{ #category : #testing }
BlKeyboardBuffer >> hasExactlyAll: aCollectionOfKeys [
	"Return true if the buffer has exactly a collection of given keys"

	^ (events keys asSet reject: #isUnkownKey) = aCollectionOfKeys asSet
]

{ #category : #initialization }
BlKeyboardBuffer >> initialize [

	super initialize.

	events := Dictionary new
]

{ #category : #testing }
BlKeyboardBuffer >> isEmpty [

	^ events isEmpty
]

{ #category : #testing }
BlKeyboardBuffer >> isNotEmpty [

	^ events isNotEmpty
]

{ #category : #testing }
BlKeyboardBuffer >> isPressed: aKey [
	"Return true if a given key is pressed, false otherwise"

	^ self hasEvent: aKey
]

{ #category : #printing }
BlKeyboardBuffer >> printOn: aStream [

	aStream nextPut: $(.
	events values
		do: [ :anEvent | aStream nextPutAll: anEvent key name asString ]
		separatedBy: [ aStream nextPutAll: ' ' ].
	aStream nextPut: $)
]

{ #category : #'adding / removing' }
BlKeyboardBuffer >> remove: anEvent [

	events removeKey: anEvent key
]
