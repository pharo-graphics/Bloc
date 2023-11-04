Class {
	#name : 'BlPtUnit',
	#superclass : 'BlUnit',
	#package : 'Bloc',
	#tag : 'Basic-Units'
}

{ #category : 'printing' }
BlPtUnit >> printOn: aStream [
	aStream nextPutAll: 'pt'
]

{ #category : 'accessing' }
BlPtUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aCurrentValueOrBlock value
]
