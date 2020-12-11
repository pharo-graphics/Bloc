Class {
	#name : #BlElementStyles,
	#superclass : #BlStyles,
	#instVars : [
		'previousAppliedStyles',
		'isDirty',
		'element'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #private }
BlElementStyles >> applyStylesForStates: aCollectionOfStates [
	| theNewAppliedStyles  |
	
	theNewAppliedStyles := self matchingStyles: aCollectionOfStates.
	
	(previousAppliedStyles difference: theNewAppliedStyles)
		ifNotEmpty: [ :theStylesToRemove | theStylesToRemove do: [ :eachStyle |
			eachStyle cleanUpOnElement: self element ] ].

	theNewAppliedStyles do: [ :eachStyle | eachStyle applyOnElement: self element ].
	previousAppliedStyles := theNewAppliedStyles asSet.

	isDirty := false
]

{ #category : #converting }
BlElementStyles >> asForwarded: aTargetObject [
	^ BlForwardedElementStyles new
		styles: (self styles collect: [ :eachStyle | eachStyle asForwarded: aTargetObject ]);
		targetObject: aTargetObject;
		element: self element
]

{ #category : #'private - adding' }
BlElementStyles >> basicAddStyle: aStyle [
	super basicAddStyle: aStyle.
	
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(self element hasEventHandler: anEventHandler)
			ifFalse: [ self element addEventHandler: anEventHandler ] ].

	self element requestStyle
]

{ #category : #'private - adding' }
BlElementStyles >> basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle [
	| thePropertiesBefore |
	
	self
		assert: [ aStyleToRemove ~~ anExistingStyle ]
		description: [ 'Must not be the same style instance' ].
		
	self
		assert: [ aStyleToRemove properties ~~ anExistingStyle properties ]
		description: [ 'Must not be the same properties instance' ].

	thePropertiesBefore := aStyleToRemove properties size.
	super basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle.
	
	self
		assert: [ thePropertiesBefore = aStyleToRemove properties size. ]
		description: [ 'Styles to remove should not be modified' ].

	self element properties removeProperties: aStyleToRemove properties.
]

{ #category : #'private - adding' }
BlElementStyles >> basicRemoveStyle: aStyle [
	super basicRemoveStyle: aStyle.
	
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(self element hasEventHandler: [ :eachHandler | eachHandler = anEventHandler ])
			ifFalse: [ self element removeEventHandler: anEventHandler ] ].

	self element requestStyle
]

{ #category : #initialization }
BlElementStyles >> createStylesCollection [
	^ SortedCollection sortUsing: #priority ascending
]

{ #category : #accessing }
BlElementStyles >> element [
	^ element
]

{ #category : #accessing }
BlElementStyles >> element: anObject [
	element := anObject
]

{ #category : #'api - styles' }
BlElementStyles >> for: aTargetObject [
	^ BlForwardedElementStyles new
		styles: self styles;
		element: self element;
		targetObject: aTargetObject
]

{ #category : #initialization }
BlElementStyles >> initialize [
	super initialize.

	isDirty := true.
	previousAppliedStyles := Set new
]

{ #category : #accessing }
BlElementStyles >> markDirty [
	isDirty := true
]

{ #category : #private }
BlElementStyles >> matchingProperties [
	"An utility debug method to get all currently matching styles"

	^ (self matchingStyles: self element states allStates) asArray flatCollect: [ :eachStyle | eachStyle properties ]
]

{ #category : #private }
BlElementStyles >> matchingStyles [
	"An utility debug method to get all currently matching styles"

	^ self matchingStyles: self element states allStates
]

{ #category : #testing }
BlElementStyles >> needsStyle [
	^ isDirty
]
