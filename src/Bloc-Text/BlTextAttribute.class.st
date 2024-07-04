Class {
	#name : #BlTextAttribute,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'isOverwritableByStyler'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #comparing }
BlTextAttribute >> = anObject [
	"Return true if I am equal to a given object"
	<return: #Boolean>
	
	self == anObject
		ifTrue: [ ^ true ].
	(anObject class = self class)
		ifFalse: [ ^ false ].

	^ self equals: anObject
]

{ #category : #'text style' }
BlTextAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
]

{ #category : #converting }
BlTextAttribute >> asBlTextAttribute [

	^ self
]

{ #category : #style }
BlTextAttribute >> beNotOverwritableByStyler [
	isOverwritableByStyler := false
]

{ #category : #style }
BlTextAttribute >> beOverwritableByStyler [
	isOverwritableByStyler := true
]

{ #category : #comparing }
BlTextAttribute >> equals: anAnotherAttribute [
	<return: #Boolean>

	^ self type == anAnotherAttribute type
]

{ #category : #comparing }
BlTextAttribute >> hash [
	"Compute and return a hash code.
	Two objects for which equals: returns true must have the same hash"
	<return: #Number>

	^ self type identityHash
]

{ #category : #initialization }
BlTextAttribute >> initialize [
	super initialize.
	
	isOverwritableByStyler := true
]

{ #category : #testing }
BlTextAttribute >> isAdornment [
	"Return true if attribute influences text structure, for examples if it replaces one or more characters
	with any amount of other arbitrary items, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #testing }
BlTextAttribute >> isEventHandler [
	"Return true if attribute is designed to handle UI events such as mouse,
	false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #testing }
BlTextAttribute >> isOverwritableByStyler [
	"Return true if attribute is overwritable by stylers, false otherwise.
	By default all attributes are treated as style ones"
	<return: #Boolean>

	^ isOverwritableByStyler
]

{ #category : #testing }
BlTextAttribute >> isParagraphAttribute [
	"Return true if I am a special paragraph attribute, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #testing }
BlTextAttribute >> isStyle [
	"Return true if attribute represents a text or font style attribute that only changes how text looks,
	for example foreground, background, weight, emphasis etc.
	By default all attributes are treated as style ones. Action attributes should return false"

	^ true
]

{ #category : #testing }
BlTextAttribute >> mayHaveExternalReferences [
	"Answer if this attribute can have references to some external objects like AST nodes or computation results"

	^ false
]

{ #category : #comparing }
BlTextAttribute >> ropeAttributeType [
	"Return an object that is used to compare attribute by type
	The rule is the following: attributes of the same type must overwrite each other."
	
	^ self type
]

{ #category : #printing }
BlTextAttribute >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'.

	isOverwritableByStyler
		ifFalse: [ aStream nextPutAll: ' ', #beNotOverwritableByStyler asString ]
]

{ #category : #comparing }
BlTextAttribute >> type [
	"Return an object that is used to compare attribute by type
	The rule is the following: attributes of the same type must overwrite each other."
	<return: #Object>
	
	^ self class
]
