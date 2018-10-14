"
I represent a text properties - a collection of attributes. They can be added dynamically with the help of corresponding api methods.

[[[
BlTextAttributesBuilder new
	bold;
	italic;
	fontSize: 30;
	fontName: 'Roboto';
	foreground: Color darkGray
]]]
"
Class {
	#name : #BlTextAttributesBuilder,
	#superclass : #Object,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'attributes'
	],
	#category : 'Bloc-Text-Text-Support'
}

{ #category : #hook }
BlTextAttributesBuilder >> applyOn: aBlText [
	"Apply these text properties on a given text"

	^ aBlText attributes: self attributes
]

{ #category : #accessing }
BlTextAttributesBuilder >> attribute: aTextAttribute [
	self attributes add: aTextAttribute
]

{ #category : #accessing }
BlTextAttributesBuilder >> attributes [
	<return: #Collection of: #BlTextAttribute>
	
	^ attributes
]

{ #category : #accessing }
BlTextAttributesBuilder >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ self
]

{ #category : #initialization }
BlTextAttributesBuilder >> initialize [
	super initialize.
	
	attributes := OrderedCollection new
]
