Class {
	#name : 'BlElementPropagatableProperties',
	#superclass : 'BlElementResolvedProperties',
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
