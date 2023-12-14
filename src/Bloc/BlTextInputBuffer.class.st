"
# Text input buffer
Collects all the text input events during a frame

"
Class {
	#name : 'BlTextInputBuffer',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'inputs'
	],
	#category : 'Bloc-Space - Events',
	#package : 'Bloc',
	#tag : 'Space - Events'
}

{ #category : 'enumerating' }
BlTextInputBuffer >> initialize [
	super initialize.
	
	inputs := OrderedCollection new
]

{ #category : 'enumerating' }
BlTextInputBuffer >> reset [
	inputs removeAll
]

{ #category : 'adding' }
BlTextInputBuffer >> text: aString modifiers: aBlKeyModifiers [
	inputs
		ifEmpty: [ inputs add: (aString -> aBlKeyModifiers copy) ]
		ifNotEmpty: [ :theInputs |
			theInputs last value = aBlKeyModifiers
				ifTrue: [ theInputs last key: theInputs last key, aString ]
				ifFalse: [ inputs add: (aString -> aBlKeyModifiers copy) ] ]
]

{ #category : 'enumerating' }
BlTextInputBuffer >> textInputEventsDo: aBlock [
	inputs do: [ :eachAssoc |
		aBlock value: (BlTextInputEvent new
			text: eachAssoc key;
			modifiers: eachAssoc value;
			yourself) ]
]
