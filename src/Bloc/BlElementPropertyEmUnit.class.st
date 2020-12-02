Class {
	#name : #BlElementPropertyEmUnit,
	#superclass : #BlElementPropertyUnit,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #printing }
BlElementPropertyEmUnit >> printOn: aStream [
	aStream nextPutAll: 'em'
]

{ #category : #accessing }
BlElementPropertyEmUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aParentValueOrBlock value * aCurrentValueOrBlock value
]
