Class {
	#name : #BlStyles,
	#superclass : #Object,
	#traits : 'TBlElementCommonStyles + TBlElementStyles',
	#classTraits : 'TBlElementCommonStyles classTrait + TBlElementStyles classTrait',
	#instVars : [
		'styles'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'adding / removing' }
BlStyles >> addStyle: aStyle [
	self
		styleForStyle: aStyle
		ifFound: [ :anExistingStyle | anExistingStyle addProperties: aStyle properties ]
		ifNone: [ self basicAddStyle: aStyle copy ]
]

{ #category : #'adding / removing' }
BlStyles >> addStyles: aCollectionOfStyles [
	aCollectionOfStyles do: [ :eachStyle | self addStyle: eachStyle ]
]

{ #category : #converting }
BlStyles >> asForwarded: aTargetObject [
	^ BlForwardedStyles new
		styles: (self styles collect: [ :eachStyle | eachStyle asForwarded: aTargetObject ]);
		targetObject: aTargetObject
]

{ #category : #'private - adding' }
BlStyles >> basicAddStyle: aStyle [
	styles add: aStyle
]

{ #category : #'private - adding' }
BlStyles >> basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle [
	anExistingStyle removeProperties: aStyleToRemove properties asArray
]

{ #category : #'private - adding' }
BlStyles >> basicRemovePropertiesOrStyleOf: aStyleToRemove fromStyle: anExistingStyle [
	self basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle.
	
	anExistingStyle hasProperties
		ifFalse: [ self basicRemoveStyle: anExistingStyle ]
]

{ #category : #'private - adding' }
BlStyles >> basicRemoveStyle: aStyle [
	styles remove: aStyle ifAbsent: [  ]
]

{ #category : #'api - styles' }
BlStyles >> for: aTargetObject [
	^ BlForwardedStyles new
		styles: self styles;
		targetObject: aTargetObject
]

{ #category : #initialization }
BlStyles >> initialize [
	super initialize.
	
	styles := SortedCollection sortUsing: #priority ascending
]

{ #category : #private }
BlStyles >> matchingStyles: theStates [
	^ styles select: [ :aStyle | aStyle state matches: theStates ]
]

{ #category : #'adding / removing' }
BlStyles >> removeStyle: aStyle [			
	self
		styleForStyle: aStyle
		ifFound: [ :anExistingStyle | self basicRemovePropertiesOrStyleOf: aStyle fromStyle: anExistingStyle ]
		ifNone: [ ]
]

{ #category : #'adding / removing' }
BlStyles >> removeStyles: aCollectionOfStyles [
	aCollectionOfStyles do: [ :eachStyle | self removeStyle: eachStyle ]
]

{ #category : #'private - adding' }
BlStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle | eachStyle isForwarded not and: [ eachStyle state = aState ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'private - adding' }
BlStyles >> styleForStyle: aStyle ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle |
			aStyle isForwarded = eachStyle isForwarded
				and: [ (aStyle isForwarded not or: [ aStyle targetObject = eachStyle targetObject ])
					and: [ eachStyle state = aStyle state ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #private }
BlStyles >> styles [
	^ styles
]

{ #category : #private }
BlStyles >> styles: aCollectionOfStyles [
	"Private! #styles must be correctly initialized with a proper sorted collection"

	styles := aCollectionOfStyles
]
