Class {
	#name : #BlStyles,
	#superclass : #Object,
	#traits : 'TBlElementStyles',
	#classTraits : 'TBlElementStyles classTrait',
	#instVars : [
		'styles'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'adding / removing' }
BlStyles >> addStyle: aStyle [
	styles
		detect: [ :eachStyle | eachStyle state = aStyle state ]
		ifFound: [ :anExistingStyle | anExistingStyle addProperties: aStyle properties asArray ]
		ifNone: [ self basicAddStyle: aStyle copy ]
]

{ #category : #'adding / removing' }
BlStyles >> addStyles: aCollectionOfStyles [
	aCollectionOfStyles do: [ :eachStyle | self addStyle: eachStyle ]
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
	styles
		detect: [ :eachStyle | eachStyle state = aStyle state or: [ eachStyle = aStyle ] ]
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
		detect: [ :eachStyle | eachStyle state = aState ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #private }
BlStyles >> styles [
	^ styles
]
