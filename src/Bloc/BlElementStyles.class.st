"
# Element styles

Is a special type of `BlStyles` which is assigned to a `BlElement`. There should be just one instance of `BlElementStyles` per element. Whenever styles are added or removed, `BlElementStyles` notifies its `BlElement` that styles have been changed, which triggers the recomputation of the styles and properties of the graphical scene. See `BlElement>>#requestStyle`.

## Accessing element styles
`BlElement>>#styles` returns existing element styles.

## Adding styles
A `BlElementStyle` can be added to the styles with the help of `BlStyles>>#addStyle:`. See the class comment of `BlStyles` to learn the details of how styles are added.
An important extra step in adding styles is the addition of an optional `BlBasicEventHandler` to the element. A `BlElementState` can implement `BlElementState>>#optionalEventHandlerDo:` whose goal is to provide `BlElementStyles` with an event handler that should be added to the element when a new style for that state is added to the element. That optional event handler is an essential part of the behavior for some styles.

Consider a style for a `BlElementPressedState`. By default, an element does not have any behavior to add or remove `BlElementPressedState` when it is being pressed, which makes sense. It only becomes necessary, when there is a style which is interested in a specific state to be added or removed. In the case of `BlElementPressedState`, a custom `BlElementPressedStateEventHandler` is added to the element, which encapsulates the logic of managing pressed state based on mouse events.

## Removing styles
See the class comment of `BlStyles` to learn the details of how styles are removed. The difference in behavior when removing styles from the `BlElementStyles` is only related to the optional event handlers that are removed when a style for a state is removed from the element. The explanation of why an optional event handler is needed can be found in the subsection ""Adding styles"".

"
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
			eachStyle cleanUpOnElement: element ] ].

	theNewAppliedStyles do: [ :eachStyle | eachStyle applyOnElement: element ].
	previousAppliedStyles := theNewAppliedStyles asSet.

	isDirty := false
]

{ #category : #converting }
BlElementStyles >> asForwarded: aTargetObject [

	^ BlForwardedElementStyles new
		  styles: 
				(self styles collect: [ :eachStyle |
					eachStyle asForwarded: aTargetObject ]);
		  targetObject: aTargetObject;
		  element: element
]

{ #category : #'private - adding' }
BlElementStyles >> basicAddStyle: aStyle [

	super basicAddStyle: aStyle.

	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(element hasEventHandler: anEventHandler) ifFalse: [
			element addEventHandler: anEventHandler ] ].

	element requestStyle
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

	self element properties removeProperties: aStyleToRemove properties
]

{ #category : #'private - adding' }
BlElementStyles >> basicRemoveStyle: aStyle [

	super basicRemoveStyle: aStyle.
	
	aStyle state optionalEventHandlerDo: [ :anEventHandler |
		(element hasEventHandler: [ :eachHandler | eachHandler = anEventHandler ])
			ifFalse: [ element removeEventHandler: anEventHandler ] ].

	element requestStyle
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
BlElementStyles >> element: aBlElement [

	element := aBlElement
]

{ #category : #'api - styles' }
BlElementStyles >> for: aTargetObject [

	^ BlForwardedElementStyles new
		  styles: self styles;
		  element: element;
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
	"An utility debug method to get all currently matching properties"

	^ (self matchingStyles: element states allStates) asArray
		  flatCollect: [ :eachStyle | eachStyle properties ]
]

{ #category : #private }
BlElementStyles >> matchingStyles [
	"An utility debug method to get all currently matching styles"

	^ self matchingStyles: element states allStates
]

{ #category : #testing }
BlElementStyles >> needsStyle [

	^ isDirty
]
