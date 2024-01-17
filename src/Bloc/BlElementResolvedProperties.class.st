Class {
	#name : #BlElementResolvedProperties,
	#superclass : #BlElementMaybeResolvedProperties,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #actions }
BlElementResolvedProperties >> applyOnElement: anElement [
	properties do: [ :eachPropertyWithStatus | eachPropertyWithStatus maybeCleanUpOnElement: anElement ].
	properties do: [ :eachPropertyWithStatus | eachPropertyWithStatus maybeApplyOnElement: anElement ]
]

{ #category : #'adding / removing' }
BlElementResolvedProperties >> flushPropertiesToRemove [
	properties := properties reject: [ :eachPropertyWithStatus | eachPropertyWithStatus isToBeRemoved ]
]

{ #category : #initialization }
BlElementResolvedProperties >> initialize [
	super initialize.
	
	properties := Dictionary new
]

{ #category : #accessing }
BlElementResolvedProperties >> mergedWithProperties: aBlElementResolvedProperties [
	| theProperties |

	theProperties := self propertiesToPropagateToChildren properties copy
		addAll: aBlElementResolvedProperties properties;
		yourself.

	^ BlElementResolvedProperties new properties: theProperties
]

{ #category : #accessing }
BlElementResolvedProperties >> mergedWithPropertiesWithStatus: aBlElementResolvedProperties [
	| theProperties |

	theProperties := Dictionary new.
	self propertiesToPropagateToChildren properties associationsDo: [ :eachAssociation |
		theProperties
			at: eachAssociation key
			put: (BlElementPropertyWithStatus new property: eachAssociation value property) ].

	theProperties addAll: aBlElementResolvedProperties properties.

	^ BlElementResolvedProperties new properties: theProperties
]

{ #category : #copying }
BlElementResolvedProperties >> postCopy [
	properties := properties copy
]

{ #category : #private }
BlElementResolvedProperties >> properties [
	<return: #Dictionary>

	^ properties
]

{ #category : #private }
BlElementResolvedProperties >> properties: aDictionaryOfProperties [
	properties := aDictionaryOfProperties
]

{ #category : #private }
BlElementResolvedProperties >> propertiesAsArray [
	^ properties values
]

{ #category : #accessing }
BlElementResolvedProperties >> propertiesToPropagateToChildren [
	
	"only properties that are not to be removed should be propagated to children"
	^ BlElementPropagatableProperties new properties: (properties
		select: [ :eachPropertyWithStatus | eachPropertyWithStatus canPropagateToChildren ]
		thenCollect: [ :eachPropertyWithStatus | eachPropertyWithStatus property ])
]

{ #category : #accessing }
BlElementResolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	^ properties
		at: aPropertyType
		ifPresent: aFoundBlock
		ifAbsent: aNoneBlock
]
