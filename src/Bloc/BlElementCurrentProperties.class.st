Class {
	#name : 'BlElementCurrentProperties',
	#superclass : 'BlElementProperties',
	#traits : 'TBlElementProperties',
	#classTraits : 'TBlElementProperties classTrait',
	#instVars : [
		'properties',
		'element',
		'isDirty',
		'resolvedProperties'
	],
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'adding / removing' }
BlElementCurrentProperties >> addProperties: aCollectionOfElementProperties [

	| anythingChanged |
	anythingChanged := false.
	aCollectionOfElementProperties do: [ :eachProperty |
		anythingChanged := anythingChanged or: (self basicAddProperty: eachProperty) ].
	anythingChanged ifTrue: [ self onPropertiesChanged ]
]

{ #category : 'adding / removing' }
BlElementCurrentProperties >> addProperty: aBlElementProperty [

	(self basicAddProperty: aBlElementProperty)
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : 'converting' }
BlElementCurrentProperties >> asArray [

	^ properties asArray
]

{ #category : 'private' }
BlElementCurrentProperties >> basicAddProperty: aBlElementProperty [
	"Return true if properties changed, false otherwise."

	properties
		at: aBlElementProperty type
		ifPresent: [ :anExistingPropertyWithStatus |
			anExistingPropertyWithStatus clearToBeRemoved.

			^ anExistingPropertyWithStatus property = aBlElementProperty
				ifTrue: [
					anExistingPropertyWithStatus clearJustAdded.
					false ]
				ifFalse: [
					anExistingPropertyWithStatus
						property: aBlElementProperty;
						clearApplied;
						addJustAdded.
					true ] ]
		ifAbsentPut: [
			(BlElementPropertyWithStatus new
				property: aBlElementProperty;
				yourself) addJustAdded ].

	^ true
]

{ #category : 'private' }
BlElementCurrentProperties >> basicRemoveProperty: aBlElementProperty [
	"We do not actually remove a property, we simply mark it as to be removed.
	This will later give a property a chance to clean up the element"

	properties
		at: aBlElementProperty type
		ifPresent: [ :anExistingPropertyWithStatus |
			anExistingPropertyWithStatus addToBeRemoved.
			^ true ].
		
	^ false
]

{ #category : 'accessing' }
BlElementCurrentProperties >> element [

	^ element
]

{ #category : 'accessing' }
BlElementCurrentProperties >> element: aBlElement [

	element := aBlElement
]

{ #category : 'adding / removing' }
BlElementCurrentProperties >> flushPropertiesToRemove [

	properties := properties reject: [ :eachPropertyWithStatus |
		eachPropertyWithStatus isToBeRemoved ].
	self maybeResolvedProperties flushPropertiesToRemove
]

{ #category : 'initialization' }
BlElementCurrentProperties >> initialize [

	super initialize.
	properties := Dictionary new.
	resolvedProperties := BlElementResolvedProperties new.
	isDirty := false
]

{ #category : 'accessing' }
BlElementCurrentProperties >> markClean [

	isDirty := false
]

{ #category : 'accessing' }
BlElementCurrentProperties >> markDirty [

	isDirty := true.
	resolvedProperties := nil
]

{ #category : 'accessing' }
BlElementCurrentProperties >> maybeResolvedProperties [

	^ resolvedProperties ifNil: [ BlElementUnresolvedProperties new ]
]

{ #category : 'testing' }
BlElementCurrentProperties >> needsPropertiesComputation [

	^ resolvedProperties isNil
]

{ #category : 'private' }
BlElementCurrentProperties >> onPropertiesChanged [

	self element requestPropertiesComputation
]

{ #category : 'copying' }
BlElementCurrentProperties >> postCopy [

	properties := properties copy
]

{ #category : 'accessing' }
BlElementCurrentProperties >> properties [
	"Answer a `Dictionary` with the properties"

	^ properties collect: [ :eachPropertyWithStatus |
		  eachPropertyWithStatus property ]
]

{ #category : 'converting' }
BlElementCurrentProperties >> propertiesWithoutStatusAsArray [
	^ Array streamContents: [ :aStream |
		properties valuesDo: [ :eachPropertyWithStatus |
			aStream nextPut: eachPropertyWithStatus property ] ]
]

{ #category : 'adding / removing' }
BlElementCurrentProperties >> removeProperties: aCollectionOfElementProperties [	
	| anythingChanged |
	
	anythingChanged := false.
	aCollectionOfElementProperties do: [ :eachProperty | anythingChanged := anythingChanged or: (self basicRemoveProperty: eachProperty) ].
	anythingChanged
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : 'adding / removing' }
BlElementCurrentProperties >> removeProperty: aBlElementProperty [
	(self basicRemoveProperty: aBlElementProperty)
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : 'accessing' }
BlElementCurrentProperties >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	| theResolvedPropertiesWithStatus |

	theResolvedPropertiesWithStatus := properties
		collect: [ :eachPropertyWithStatus | eachPropertyWithStatus resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties ].
		
	^ resolvedProperties := theParentProperties
		mergedWithPropertiesWithStatus: (BlElementResolvedProperties new properties: theResolvedPropertiesWithStatus)
]
