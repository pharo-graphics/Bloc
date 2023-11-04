"
# Styles

Represents a set of `BlElementStyle` and is responsible for properly adding, removing and matching styles.
`BlStyles` also plays a role of a factory to define styles for most commonly used `BlElementState`. By design, there can only be one style per state in `BlStyles`, and merged otherwise.

## General styles
Being a root in the hierarchy, `BlStyles` only knows a collection of `BlElementStyle` without any specific knowledge of the owner `BlElement`. This means it is possible to construct `BlStyles` independently from the element. 
In fact, users may want to be able to construct multiple sets of styles and then merge them together by adding to an element.

## Element styles
A notable member of the styles hierarchy is `BlElementStyles`, which, as the name suggests, belongs to an element. Compared to the generic `BlStyles` it notifies its element when a new style is added or removed, which allows the graphical scene to recompute and apply new styles if they match element's state. It also knows how to apply styles that match element's state. See `BlElementStyles` to learn more.

## Forwarded styles
By default, styles are applied on the same element to which that collection of styles is assigned (see `BlElementStyles`). However, sometimes users may want to apply styles on a child element based on the state of its parent, therefore we should be able to forward styles to some other arbitrary element. A simple example would be a button widget, which has a text element as its child. Users may want to decide to change the text color of the text child element based on the hovered or pressed state of the parent Button element. In this case, forwarded styles is the only nice declarative way to implement such behavior. See `BlForwardedStyles` and `BlForwardedElementStyles` to learn more.

## Adding styles
A `BlElementStyle` can be added to the styles with the help of `BlStyles>>#addStyle:`. As previously shortly mentioned, there can be just one `BlElementStyle` per `BlElementState`. It means that whenever a new style is being added, `BlStyles` first tries to find an existing style that corresponds to the state of the new added style. If such style exists, the properties of the added style are merged (with override) into the properties of an existing style. Otherwise, a copy of the provided style is added to `BlStyles`. The fact that a copy is added instead of the style itself is an important property which guarantees that `BlStyles` is self-contained and can not be externally modified if any of the previously added style is changed. If it would be possible to indirectly modify existing `BlStyles` by altering the state of the individual styles, the fact of a change would go unnoticed by the library, which can lead to confusion and difficult debugging.

## Removing styles
A `BlElementStyle` can be removed from the styles with the help of `BlStyles>>#removeStyle:`. Similarly to the logic of adding new styles, removing existing styles is not based on the identity of the intended style to remove, but instead based on its state and properties. In fact, removing a style is practically the same as removing a set of properties of that style.

"
Class {
	#name : #BlStyles,
	#superclass : #Object,
	#traits : 'TBlElementCommonStyles + TBlElementStyles',
	#classTraits : 'TBlElementCommonStyles classTrait + TBlElementStyles classTrait',
	#instVars : [
		'styles'
	],
	#category : 'Bloc-Basic-Style'
}

{ #category : 'adding / removing' }
BlStyles >> addStyle: aStyle [

	self
		styleForStyle: aStyle
		ifFound: [ :anExistingStyle |
			anExistingStyle addProperties: aStyle properties ]
		ifNone: [ self basicAddStyle: aStyle copy ]
]

{ #category : 'adding / removing' }
BlStyles >> addStyles: aCollectionOfStyles [

	aCollectionOfStyles do: [ :eachStyle | self addStyle: eachStyle ]
]

{ #category : 'converting' }
BlStyles >> asForwarded: aTargetObject [

	^ BlForwardedStyles new
		  styles: 
			(self styles collect: [ :eachStyle |
				eachStyle asForwarded: aTargetObject ]);
		  targetObject: aTargetObject;
		  yourself
]

{ #category : 'private - adding' }
BlStyles >> basicAddStyle: aStyle [

	styles add: aStyle
]

{ #category : 'private - adding' }
BlStyles >> basicRemovePropertiesOf: aStyleToRemove fromStyle: anExistingStyle [

	anExistingStyle removeProperties: aStyleToRemove properties
]

{ #category : 'private - adding' }
BlStyles >> basicRemovePropertiesOrStyleOf: aStyleToRemove fromStyle: anExistingStyle [

	self
		basicRemovePropertiesOf: aStyleToRemove
		fromStyle: anExistingStyle.

	anExistingStyle hasProperties ifFalse: [
		self basicRemoveStyle: anExistingStyle ]
]

{ #category : 'private - adding' }
BlStyles >> basicRemoveStyle: aStyle [

	styles remove: aStyle ifAbsent: [  ]
]

{ #category : 'initialization' }
BlStyles >> createStylesCollection [

	^ OrderedCollection new: 10
]

{ #category : 'api - styles' }
BlStyles >> for: aTargetObject [

	^ BlForwardedStyles new
		  styles: self styles;
		  targetObject: aTargetObject;
		  yourself
]

{ #category : 'initialization' }
BlStyles >> initialize [

	super initialize.

	styles := self createStylesCollection
]

{ #category : 'private' }
BlStyles >> matchingStyles: theStates [

	^ styles select: [ :aStyle | aStyle state matches: theStates ]
]

{ #category : 'adding / removing' }
BlStyles >> removeStyle: aStyle [

	self
		styleForStyle: aStyle
		ifFound: [ :anExistingStyle |
			self
				basicRemovePropertiesOrStyleOf: aStyle
				fromStyle: anExistingStyle ]
		ifNone: [  ]
]

{ #category : 'adding / removing' }
BlStyles >> removeStyles: aCollectionOfStyles [

	aCollectionOfStyles do: [ :eachStyle | self removeStyle: eachStyle ]
]

{ #category : 'private - adding' }
BlStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle | eachStyle isForwarded not and: [ eachStyle state = aState ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'private - adding' }
BlStyles >> styleForStyle: aStyle ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle |
			aStyle isForwarded = eachStyle isForwarded
				and: [ (aStyle isForwarded not or: [ aStyle targetObject = eachStyle targetObject ])
					and: [ eachStyle state = aStyle state ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'private' }
BlStyles >> styles [

	^ styles
]

{ #category : 'private' }
BlStyles >> styles: aCollectionOfStyles [
	"Private! #styles must be correctly initialized with a proper sorted collection"

	styles := aCollectionOfStyles
]
