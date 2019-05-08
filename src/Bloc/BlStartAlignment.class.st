Class {
	#name : #BlStartAlignment,
	#superclass : #BlRelativeAlignment,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #factory }
BlStartAlignment class >> horizontal [
	^ BlHorizontalAlignment start
]

{ #category : #factory }
BlStartAlignment class >> vertical [
	^ BlVerticalAlignment top
]
