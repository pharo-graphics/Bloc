Class {
	#name : #BlElementPropagatableProperties,
	#superclass : #BlElementResolvedProperties,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'adding / removing' }
BlElementPropagatableProperties >> flushPropertiesToRemove [
]

{ #category : #accessing }
BlElementPropagatableProperties >> propertiesToPropagateToChildren [
	^ self
]
