Class {
	#name : 'BlStartAlignment',
	#superclass : 'BlRelativeAlignment',
	#category : 'Bloc-Layouts-Alignment',
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
