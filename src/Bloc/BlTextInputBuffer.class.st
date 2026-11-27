"
# Text input buffer
Collects all the text input events during a frame

"
Class {
	#name : #BlTextInputBuffer,
	#superclass : #Object,
	#instVars : [
		'inputs'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #initialization }
BlTextInputBuffer >> initialize [

	super initialize.
	
	inputs := OrderedCollection new
]

{ #category : #enumerating }
BlTextInputBuffer >> reset [

	inputs removeAll
]

{ #category : #adding }
BlTextInputBuffer >> text: aString modifiers: aBlKeyModifiers [

	inputs ifNotEmpty: [
		| lastInput |
		lastInput := inputs last.
		lastInput value = aBlKeyModifiers ifTrue: [
			lastInput key: lastInput key, aString.
			^ self ] ].

	inputs add: (aString -> aBlKeyModifiers copy)
]

{ #category : #enumerating }
BlTextInputBuffer >> textInputEventsDo: aBlock [

	inputs do: [ :eachAssociation |
		aBlock value:
			(BlTextInputEvent new
				text: eachAssociation key;
				modifiers: eachAssociation value;
				yourself) ]
]
