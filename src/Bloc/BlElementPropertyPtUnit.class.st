Class {
	#name : #BlElementPropertyPtUnit,
	#superclass : #BlElementPropertyUnit,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #printing }
BlElementPropertyPtUnit >> printOn: aStream [
	aStream nextPutAll: 'pt'
]

{ #category : #accessing }
BlElementPropertyPtUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ aCurrentValueOrBlock value
]
