Class {
	#name : #BlElementPropertyRemUnit,
	#superclass : #BlElementPropertyUnit,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #printing }
BlElementPropertyRemUnit >> printOn: aStream [
	aStream nextPutAll: 'rem'
]

{ #category : #accessing }
BlElementPropertyRemUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aGlobalValueOrBlock value * aCurrentValueOrBlock value
]
