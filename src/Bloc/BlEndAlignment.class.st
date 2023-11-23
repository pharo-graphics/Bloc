Class {
	#name : 'BlEndAlignment',
	#superclass : 'BlRelativeAlignment',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlEndAlignment class >> horizontal [
	^ BlHorizontalAlignment end
]

{ #category : 'factory' }
BlEndAlignment class >> vertical [
	^ BlVerticalAlignment bottom
]
