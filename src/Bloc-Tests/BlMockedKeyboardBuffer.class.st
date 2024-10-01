"
I am a special mocked keyboard buffer with configurable key pressed state for testing purposes
"
Class {
	#name : #BlMockedKeyboardBuffer,
	#superclass : #BlKeyboardBuffer,
	#instVars : [
		'states'
	],
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #testing }
BlMockedKeyboardBuffer >> hasExactlyAll: aCollectionOfKeys [
	"Return true if the buffer has exactly a collection of given keys"

	^ (states associations select: #value thenCollect: #key) asSet = aCollectionOfKeys asSet
]

{ #category : #initialization }
BlMockedKeyboardBuffer >> initialize [

	super initialize.

	states := Dictionary new
]

{ #category : #testing }
BlMockedKeyboardBuffer >> isPressed: aKey [
	"Return true if a given key is pressed, false otherwise"

	^ states at: aKey
]

{ #category : #accessing }
BlMockedKeyboardBuffer >> pressed: aBoolean key: aKey [

	states at: aKey put: aBoolean
]
