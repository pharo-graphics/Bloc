Class {
	#name : #BlElementPropagatableProperties,
	#superclass : #BlElementResolvedProperties,
	#category : 'Bloc-Basic-Properties'
}

{ #category : #'adding / removing' }
BlElementPropagatableProperties >> flushPropertiesToRemove [
]

{ #category : #initialization }
BlElementPropagatableProperties >> initialize [
	super initialize.
	
	properties := Dictionary new
]

{ #category : #accessing }
BlElementPropagatableProperties >> propertiesToPropagateToChildren [
	^ self
]
