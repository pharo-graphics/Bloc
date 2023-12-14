Class {
	#name : 'BlElementUnresolvedProperties',
	#superclass : 'BlElementMaybeResolvedProperties',
	#category : 'Bloc-Basic-Properties',
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'actions' }
BlElementUnresolvedProperties >> applyOnElement: anElement [
]

{ #category : 'adding / removing' }
BlElementUnresolvedProperties >> flushPropertiesToRemove [
]

{ #category : 'accessing' }
BlElementUnresolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	^ aNoneBlock value
]
