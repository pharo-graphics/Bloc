"
I am a special mocked key combination with predefined matching behaviour based on settable booleans
"
Class {
	#name : #BlMockedKeyCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'shouldMatch'
	],
	#category : 'Bloc-Tests-KeyBinding'
}

{ #category : #visiting }
BlMockedKeyCombination >> accept: aKeyCombinationVisitor [
	
]

{ #category : #'key matching' }
BlMockedKeyCombination >> match: aKeyboardBuffer [
	^ 0
]

{ #category : #'key matching' }
BlMockedKeyCombination >> matches: anEventBuffer [
	^ shouldMatch
]

{ #category : #accessing }
BlMockedKeyCombination >> shouldMatch [
	^ shouldMatch
]

{ #category : #accessing }
BlMockedKeyCombination >> shouldMatch: anObject [
	shouldMatch := anObject
]
