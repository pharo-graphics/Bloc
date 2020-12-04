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
	properties do: [ :eachProperty | eachProperty applyOnElement: anElement ]
]

{ #category : #'adding / removing' }
BlElementResolvedProperties >> flushPropertiesToRemove [
	properties := properties reject: [ :eachPropertyWithStatus | eachPropertyWithStatus isToBeRemoved ]
]

{ #category : #accessing }
BlElementResolvedProperties >> mergedWithProperties: aBlElementResolvedProperties [
	| theProperties |

	theProperties := self propertiesToPropagateToChildren properties copy
		addAll: aBlElementResolvedProperties properties;
		yourself.

	^ BlElementResolvedProperties new properties: theProperties
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
