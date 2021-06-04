"
# Element style
An element style is an association between {{gtClass:BlElementState}} and corresponding collection of {{gtClass:BlElementProperty}}. {{gtClass:BlElementStyle}} is responsible for managing properties and applying them on an element. {{gtClass:BlElementStyle}} is usually grouped as {{gtClass:BlStyles}} or stored in the element as part of {{gtClass:BlElementStyles}}.
## Properties
In addition to general api to add and remove {{gtClass:BlElementProperty}}, {{gtClass:BlElementStyle}} by using {{gtClass:TBlElementProperties}} allows users to fluently add most common properties such as {{gtMethod:TBlElementProperties>>#background:}} or {{gtMethod:TBlElementProperties>>#border:}}.

"
Class {
	#name : #BlElementStyle,
	#superclass : #Object,
	#traits : 'TBlElementProperties',
	#classTraits : 'TBlElementProperties classTrait',
	#instVars : [
		'state',
		'properties'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'adding / removing' }
BlElementStyle >> addProperties: aCollectionOfElementProperty [
	self properties addProperties: aCollectionOfElementProperty
]

{ #category : #'adding / removing' }
BlElementStyle >> addProperty: aBlElementProperty [
	self properties addProperty: aBlElementProperty
]

{ #category : #actions }
BlElementStyle >> applyOnElement: anElement [
	anElement properties addProperties: self properties
]

{ #category : #converting }
BlElementStyle >> asForwarded: aTargetObject [
	^ BlElementForwardedStyle new
		state: self state;
		properties: self properties copy;
		targetObject: aTargetObject
]

{ #category : #actions }
BlElementStyle >> cleanUpOnElement: anElement [
	anElement properties removeProperties: self properties
]

{ #category : #testing }
BlElementStyle >> hasProperties [
	^ self properties isNotEmpty
]

{ #category : #initialization }
BlElementStyle >> initialize [
	super initialize.
	
	properties := BlElementIntendedProperties new
]

{ #category : #testing }
BlElementStyle >> isForwarded [
	^ false
]

{ #category : #copying }
BlElementStyle >> postCopy [
	state := state copy.
	properties := properties copy
]

{ #category : #printing }
BlElementStyle >> printOn: aStream [
	aStream
		nextPutAll: 'when: ';
		print: self state;
		nextPutAll: ' properties ';
		print: self properties
]

{ #category : #accessing }
BlElementStyle >> priority [
	^ self state priority
]

{ #category : #accessing }
BlElementStyle >> properties [
	<return: #BlElementProperties>

	^ properties
]

{ #category : #private }
BlElementStyle >> properties: aBlElementProperties [
	properties := aBlElementProperties
]

{ #category : #'adding / removing' }
BlElementStyle >> removeProperties: aCollectionOfElementProperty [
	self properties removeProperties: aCollectionOfElementProperty
]

{ #category : #'adding / removing' }
BlElementStyle >> removeProperty: aBlElementProperty [
	self properties removeProperty: aBlElementProperty
]

{ #category : #accessing }
BlElementStyle >> state [
	<return: #BrInteractionState>

	^ state
]

{ #category : #private }
BlElementStyle >> state: anInteractionState [
	state := anInteractionState
]
