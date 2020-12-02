Class {
	#name : #BlElementFontSizeProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'fontSize'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #defaults }
BlElementFontSizeProperty class >> default [
	^ self new fontSize: (BlElementPropertyLength pt: 16)
]

{ #category : #defaults }
BlElementFontSizeProperty class >> defaultFontSize [
	^ BlElementPropertyLength pt: 16
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
	<return: #BlElementPropertyLength>

	^ fontSize
]

{ #category : #accessing }
BlElementFontSizeProperty >> fontSize: aBlElementPropertyLength [
	fontSize := aBlElementPropertyLength
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

	^ self class new fontSize: (BlElementPropertyLength pt: aResolvedValue)
]
