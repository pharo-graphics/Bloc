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
	#category : #'Bloc-Text-Text-Support'
}

{ #category : #hook }
BlTextAttributesBuilder >> applyOn: aBlText [
	"Apply these text properties on a given text"

	^ aBlText attributes: self attributes
]

{ #category : #accessing }
BlTextAttributesBuilder >> attribute: aTextAttribute [
	| anExistingAttributeIndex |

	anExistingAttributeIndex := (self attributes
		detectIndex: [ :eachAttribute | eachAttribute type = aTextAttribute type ]
		ifNone: [ 0 ]).

	anExistingAttributeIndex isZero
		ifTrue: [ self attributes add: aTextAttribute ]
		ifFalse: [ self attributes at: anExistingAttributeIndex put: aTextAttribute ]
]

{ #category : #accessing }
BlTextAttributesBuilder >> attributes [
	<return: #Collection of: #BlTextAttribute>
	
	^ attributes
]

{ #category : #hook }
BlTextAttributesBuilder >> attributes: aCollectionOfAttributes [
	aCollectionOfAttributes do: [ :eachAttribute | self attribute: eachAttribute ]
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
