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
	anElement properties addProperties: self properties asArray
]

{ #category : #'api - properties' }
BlElementStyle >> dynamic: aBlock [
	self addProperty: (BlElementDynamicProperty new action: aBlock)
]

{ #category : #'api - properties' }
BlElementStyle >> foreground: aPaint [
	self addProperty: (BlElementForegroundProperty new foreground: aPaint)
]

{ #category : #testing }
BlElementStyle >> hasProperties [
	^ self properties isNotEmpty
]

{ #category : #initialization }
BlElementStyle >> initialize [
	super initialize.
	
	properties := BlElementProperties new
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

{ #category : #accessing }
BlElementStyle >> state: anInteractionState [
	state := anInteractionState
]
