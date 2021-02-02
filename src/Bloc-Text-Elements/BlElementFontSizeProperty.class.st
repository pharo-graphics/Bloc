Class {
	#name : #BlElementFontSizeProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'fontSize'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #defaults }
BlElementFontSizeProperty class >> default [
	^ self new fontSize: self defaultFontSize
]

{ #category : #defaults }
BlElementFontSizeProperty class >> defaultFontSize [
	^ BlValueWithUnit pt: BlFont defaultFontSize
]

{ #category : #comparing }
BlElementFontSizeProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ fontSize = anObject fontSize
]

{ #category : #'api - property' }
BlElementFontSizeProperty >> applyOnElement: anElement [
	(anElement respondsTo: #fontSize:)
		ifTrue: [ anElement fontSize: self fontSize value ]
]

{ #category : #testing }
BlElementFontSizeProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
BlElementFontSizeProperty >> fontSize [
	<return: #BlValueWithUnit>

	^ fontSize
]

{ #category : #accessing }
BlElementFontSizeProperty >> fontSize: aBlElementPropertyLength [
	fontSize := aBlElementPropertyLength isNumber
		ifTrue: [ BlValueWithUnit pt: aBlElementPropertyLength ]
		ifFalse: [ aBlElementPropertyLength ]
]

{ #category : #comparing }
BlElementFontSizeProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ fontSize hash
]

{ #category : #'api - property' }
BlElementFontSizeProperty >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	| aResolvedValue |

	aResolvedValue := self fontSize unit
		resolveLengthForValue: [ self fontSize value ]
		parent: [
			theParentProperties
				propertyAt: self class
				ifFound: [ :aResolvedParentProperty | aResolvedParentProperty fontSize value ]
				ifNone: [ self class defaultFontSize value ] ]
		global: [
			theGlobalProperties
				propertyAt: self class
				ifFound: [ :aResolvedParentProperty | aResolvedParentProperty fontSize value ]
				ifNone: [ self class defaultFontSize value ] ].

	^ self class new fontSize: (BlValueWithUnit pt: aResolvedValue)
]
