Class {
	#name : #BlElementResolvedProperties,
	#superclass : #BlElementMaybeResolvedProperties,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #actions }
BlElementResolvedProperties >> applyOnElement: anElement [
	properties do: [ :eachProperty | eachProperty applyOnElement: anElement ]
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

{ #category : #accessing }
BlElementResolvedProperties >> propertiesToPropagateToChildren [
	^ BlElementPropagatableProperties new properties: (properties select: [ :eachProperty | eachProperty canPropagateToChildren ])
]

{ #category : #accessing }
BlElementResolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	^ properties
		at: aPropertyType
		ifPresent: aFoundBlock
		ifAbsent: aNoneBlock
]
