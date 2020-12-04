Class {
	#name : #BlElementStyles,
	#superclass : #BlStyles,
	#instVars : [
		'isDirty',
		'element'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #private }
BlElementStyles >> applyStylesForStates: aCollectionOfStates [
	(self matchingStyles: aCollectionOfStates)
		do: [ :eachStyle | eachStyle applyOnElement: self element ].
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
	super basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle.
	
	self element properties removeProperties: aStyleToRemove properties asArray
]

{ #category : #'private - adding' }
BlElementStyles >> basicRemoveStyle: aStyle [
	super basicRemoveStyle: aStyle.
	
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(self element hasEventHandler: [ :eachHandler | eachHandler = anEventHandler ])
			ifFalse: [ self element removeEventHandler: anEventHandler ] ].

	self element requestStyle
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

	isDirty := true
]

{ #category : #accessing }
BlElementStyles >> markDirty [
	isDirty := true
]

{ #category : #testing }
BlElementStyles >> needsStyle [
	^ isDirty
]
