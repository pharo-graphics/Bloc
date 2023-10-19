Class {
	#name : 'BlElementPropagatableProperties',
	#superclass : 'BlElementResolvedProperties',
	#category : 'Bloc-Basic-Properties',
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'adding / removing' }
BlElementPropagatableProperties >> flushPropertiesToRemove [
]

{ #category : 'initialization' }
BlElementPropagatableProperties >> initialize [
	super initialize.
	
	properties := Dictionary new
]

{ #category : 'accessing' }
BlElementPropagatableProperties >> propertiesToPropagateToChildren [
	^ self
]
