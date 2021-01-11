Class {
	#name : #BlElementCurrentProperties,
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
BlElementCurrentProperties >> addProperties: aCollectionOfElementProperties [
	| anythingChanged |
	
	anythingChanged := false.
	aCollectionOfElementProperties do: [ :eachProperty | anythingChanged := anythingChanged or: (self basicAddProperty: eachProperty) ].
	anythingChanged
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #'adding / removing' }
BlElementCurrentProperties >> addProperty: aBlElementProperty [
	(self basicAddProperty: aBlElementProperty)
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #converting }
BlElementCurrentProperties >> asArray [
	^ properties asArray
]

{ #category : #private }
BlElementCurrentProperties >> basicAddProperty: aBlElementProperty [
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
BlElementCurrentProperties >> basicRemoveProperty: aBlElementProperty [
	"We do not actually remove a property, we simply mark it as to be removed.
	This will later give a property a chance to clean up the element"
	<return: #Boolean>

	properties
		at: aBlElementProperty type
		ifPresent: [ :anExistingPropertyWithStatus |
			anExistingPropertyWithStatus addToBeRemoved.
			^ true ].
		
	^ false
]

{ #category : #accessing }
BlElementCurrentProperties >> element [
	^ element
]

{ #category : #accessing }
BlElementCurrentProperties >> element: anObject [
	element := anObject
]

{ #category : #'adding / removing' }
BlElementCurrentProperties >> flushPropertiesToRemove [
	properties := properties reject: [ :eachPropertyWithStatus | eachPropertyWithStatus isToBeRemoved ].
	self maybeResolvedProperties flushPropertiesToRemove
]

{ #category : #'api - properties font' }
BlElementCurrentProperties >> fontSizeEm: aNumber [
	self fontSize: (BlValueWithUnit em: aNumber)
]

{ #category : #'api - properties font' }
BlElementCurrentProperties >> fontSizePt: aNumber [
	self fontSize: (BlValueWithUnit pt: aNumber)
]

{ #category : #'api - properties font' }
BlElementCurrentProperties >> fontSizeRem: aNumber [
	self fontSize: (BlValueWithUnit rem: aNumber)
]

{ #category : #initialization }
BlElementCurrentProperties >> initialize [
	super initialize.
	
	properties := Dictionary new.
	isDirty := false
]

{ #category : #accessing }
BlElementCurrentProperties >> markClean [
	isDirty := false
]

{ #category : #accessing }
BlElementCurrentProperties >> markDirty [
	isDirty := true.
	resolvedProperties := nil
]

{ #category : #accessing }
BlElementCurrentProperties >> maybeResolvedProperties [
	^ resolvedProperties ifNil: [ BlElementUnresolvedProperties new ]
]

{ #category : #testing }
BlElementCurrentProperties >> needsPropertiesComputation [
	<return: #Boolean>

	^ resolvedProperties isNil
]

{ #category : #private }
BlElementCurrentProperties >> onPropertiesChanged [
	self element requestPropertiesComputation
]

{ #category : #copying }
BlElementCurrentProperties >> postCopy [
	properties := properties copy
]

{ #category : #accessing }
BlElementCurrentProperties >> properties [
	<return: #Dictionary>

	^ properties collect: [ :eachPropertyWithStatus |  eachPropertyWithStatus property ]
]

{ #category : #'adding / removing' }
BlElementCurrentProperties >> removeProperties: aCollectionOfElementProperties [	
	| anythingChanged |
	
	anythingChanged := false.
	aCollectionOfElementProperties do: [ :eachProperty | anythingChanged := anythingChanged or: (self basicRemoveProperty: eachProperty) ].
	anythingChanged
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #'adding / removing' }
BlElementCurrentProperties >> removeProperty: aBlElementProperty [
	(self basicRemoveProperty: aBlElementProperty)
		ifTrue: [ self onPropertiesChanged ]
]

{ #category : #accessing }
BlElementCurrentProperties >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	| theResolvedProperties |

	theResolvedProperties := properties
		collect: [ :eachPropertyWithStatus | eachPropertyWithStatus resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties ].

	^ resolvedProperties := BlElementResolvedProperties new properties: theResolvedProperties
]
