Class {
	#name : #BlElementLocalProperties,
	#superclass : #BlElementProperties,
	#traits : 'TBlElementProperties - {#addProperty:}',
	#classTraits : 'TBlElementProperties classTrait',
	#instVars : [
		'element',
		'isDirty',
		'resolvedProperties'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlElementLocalProperties >> element [
	^ element
]

{ #category : #accessing }
BlElementLocalProperties >> element: anObject [
	element := anObject
]

{ #category : #'api - properties' }
BlElementLocalProperties >> foreground: aPaint [
	self addProperty: (BlElementForegroundProperty new foreground: aPaint)
]

{ #category : #initialization }
BlElementLocalProperties >> initialize [
	super initialize.

	isDirty := false
]

{ #category : #accessing }
BlElementLocalProperties >> markDirty [
	isDirty := nil.
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
	super onPropertiesChanged.
	
	self element requestPropertiesComputation
]

{ #category : #accessing }
BlElementLocalProperties >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	| theResolvedProperties |

	theResolvedProperties := properties
		collect: [ :eachProperty | eachProperty resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties ].

	^ resolvedProperties := BlElementResolvedProperties new properties: theResolvedProperties
]

{ #category : #accessing }
BlElementLocalProperties >> resolvedPropertiesDo: aBlock [
	resolvedProperties ifNotNil: aBlock
]
