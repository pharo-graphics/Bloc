Class {
	#name : 'BlStartAlignment',
	#superclass : 'BlRelativeAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlStartAlignment class >> horizontal [
	^ BlHorizontalAlignment start
]

{ #category : 'factory' }
BlStartAlignment class >> vertical [
	^ BlVerticalAlignment top
]
