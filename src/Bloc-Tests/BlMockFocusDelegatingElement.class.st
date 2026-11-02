"
I am a mock composite element used in tests to demonstrate focus delegation to a descendant element (via #focusDelegate).
"
Class {
	#name : #BlMockFocusDelegatingElement,
	#superclass : #BlElement,
	#instVars : [
		'focusDelegate'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #'focus requesting' }
BlMockFocusDelegatingElement >> focusDelegate [

	^ focusDelegate
		ifNil: [ super focusDelegate ]
		ifNotNil: [ focusDelegate focusDelegate ]
]

{ #category : #accessing }
BlMockFocusDelegatingElement >> focusDelegate: anElement [

	focusDelegate := anElement
]
