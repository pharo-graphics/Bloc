"
!Element properties
That can be propagated from the parent element to the children.
For example font size is by default inherited by the children
"
Class {
	#name : #BlElementProperties,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'adding / removing' }
BlElementProperties >> addProperties: aCollectionOfBlElementProperty [
	aCollectionOfBlElementProperty do: [ :eachProperty | self basicAddProperty: eachProperty ].
	self onPropertiesChanged
]

{ #category : #'adding / removing' }
BlElementProperties >> addProperty: aBlElementProperty [
	self basicAddProperty: aBlElementProperty.
	self onPropertiesChanged
]

{ #category : #converting }
BlElementProperties >> asArray [
	^ properties asArray
]

{ #category : #private }
BlElementProperties >> basicAddProperty: aBlElementProperty [
	properties
		at: aBlElementProperty class
		put: aBlElementProperty
]

{ #category : #private }
BlElementProperties >> basicRemoveProperty: aBlElementProperty [
	properties
		removeKey: aBlElementProperty class
		ifAbsent: [
			properties
				keysAndValuesRemove: [ :eachPropertyType :eachProperty |
					eachProperty = aBlElementProperty ] ]
]

{ #category : #initialization }
BlElementProperties >> initialize [
	super initialize.
	
	properties := IdentityDictionary new
]

{ #category : #testing }
BlElementProperties >> isEmpty [
	^ properties isEmpty
]

{ #category : #testing }
BlElementProperties >> isNotEmpty [
	^ properties isNotEmpty
]

{ #category : #hooks }
BlElementProperties >> onPropertiesChanged [
]

{ #category : #copying }
BlElementProperties >> postCopy [
	properties := properties copy
]

{ #category : #printing }
BlElementProperties >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' properties: ';
		print: properties
]

{ #category : #private }
BlElementProperties >> properties: aDictionaryOfProperties [
	properties := aDictionaryOfProperties
]

{ #category : #'adding / removing' }
BlElementProperties >> removeProperties: aCollectionOfElementProperties [
	aCollectionOfElementProperties do: [ :eachProperty | self basicRemoveProperty: eachProperty ].
	self onPropertiesChanged
]

{ #category : #'adding / removing' }
BlElementProperties >> removeProperty: aBlElementProperty [
	self basicRemoveProperty: aBlElementProperty.
	self onPropertiesChanged
]
