Class {
	#name : #BlElementLocalProperties,
	#superclass : #BlElementProperties,
	#traits : 'TBlElementProperties - {#addProperty:}',
	#classTraits : 'TBlElementProperties classTrait',
	#instVars : [
		'properties',
		'element',
		'isDirty',
		'resolvedProperties'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'adding / removing' }
BlElementLocalProperties >> addProperties: aCollectionOfBlElementProperty [
	| anythingChanged |
	
	anythingChanged := false.
	aCollectionOfBlElementProperty do: [ :eachProperty | anythingChanged := anythingChanged or: (self basicAddProperty: eachProperty) ].
	anythingChanged
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #'adding / removing' }
BlElementLocalProperties >> addProperty: aBlElementProperty [
	(self basicAddProperty: aBlElementProperty)
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #converting }
BlElementLocalProperties >> asArray [
	^ properties asArray
]

{ #category : #private }
BlElementLocalProperties >> basicAddProperty: aBlElementProperty [
	"Return true if properties changed, false otherwise"
	<return: #Boolean>

	properties
		at: aBlElementProperty type
		ifPresent: [ :anExistingPropertyWithStatus |
			anExistingPropertyWithStatus clearToBeRemoved.

			^ anExistingPropertyWithStatus property = aBlElementProperty
				ifTrue: [
					anExistingPropertyWithStatus clearJustAdded.
					false ]
				ifFalse: [
					anExistingPropertyWithStatus property: aBlElementProperty.
					anExistingPropertyWithStatus clearApplied.
					anExistingPropertyWithStatus addJustAdded.
					true ] ]
		ifAbsentPut: [ (BlElementPropertyWithStatus new property: aBlElementProperty) addJustAdded ].

	^ true
]

{ #category : #private }
BlElementLocalProperties >> basicRemoveProperty: aBlElementProperty [
	properties
		removeKey: aBlElementProperty type
		ifAbsent: [
			properties
				keysAndValuesRemove: [ :eachPropertyType :eachProperty |
					eachProperty = aBlElementProperty ] ]
]

{ #category : #accessing }
BlElementLocalProperties >> element [
	^ element
]

{ #category : #accessing }
BlElementLocalProperties >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BlElementLocalProperties >> initialize [
	super initialize.
	
	properties := IdentityDictionary new.
	isDirty := false
]

{ #category : #accessing }
BlElementLocalProperties >> markClean [
	isDirty := false
]

{ #category : #accessing }
BlElementLocalProperties >> markDirty [
	isDirty := true.
	resolvedProperties := nil
]

{ #category : #accessing }
BlElementLocalProperties >> maybeResolvedProperties [
	^ resolvedProperties ifNil: [ BlElementUnresolvedProperties new ]
]

{ #category : #testing }
BlElementLocalProperties >> needsPropertiesComputation [
	<return: #Boolean>

	^ resolvedProperties isNil
]

{ #category : #private }
BlElementLocalProperties >> onPropertiesChanged [
	self element requestPropertiesComputation
]

{ #category : #copying }
BlElementLocalProperties >> postCopy [
	properties := properties copy
]

{ #category : #'adding / removing' }
BlElementLocalProperties >> removeProperties: aCollectionOfElementProperties [
	aCollectionOfElementProperties do: [ :eachProperty | self basicRemoveProperty: eachProperty ].
	self onPropertiesChanged
]

{ #category : #'adding / removing' }
BlElementLocalProperties >> removeProperty: aBlElementProperty [
	self basicRemoveProperty: aBlElementProperty.
	self onPropertiesChanged
]

{ #category : #accessing }
BlElementLocalProperties >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	| theResolvedProperties |

	theResolvedProperties := properties
		collect: [ :eachPropertyWithStatus | eachPropertyWithStatus resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties ].

	^ resolvedProperties := BlElementResolvedProperties new properties: theResolvedProperties
]
