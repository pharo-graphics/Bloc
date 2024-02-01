Class {
	#name : #BlStartAlignment,
	#superclass : #BlRelativeAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #factory }
BlStartAlignment class >> horizontal [
	^ BlHorizontalAlignment start
]

{ #category : #'class initialization' }
BlStartAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #factory }
BlStartAlignment class >> vertical [
	^ BlVerticalAlignment top
]
