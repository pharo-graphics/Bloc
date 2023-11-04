Class {
	#name : 'BlRemUnit',
	#superclass : 'BlUnit',
	#package : 'Bloc',
	#tag : 'Basic-Units'
}

{ #category : 'printing' }
BlRemUnit >> printOn: aStream [
	aStream nextPutAll: 'rem'
]

{ #category : 'accessing' }
BlRemUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aGlobalValueOrBlock value * aCurrentValueOrBlock value
]
