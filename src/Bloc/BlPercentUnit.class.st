Class {
	#name : 'BlPercentUnit',
	#superclass : 'BlUnit',
	#package : 'Bloc',
	#tag : 'Basic-Units'
}

{ #category : 'printing' }
BlPercentUnit >> printOn: aStream [
	aStream nextPutAll: '%'
]

{ #category : 'accessing' }
BlPercentUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aCurrentValueOrBlock value / 100.0 * aParentValueOrBlock value
]
