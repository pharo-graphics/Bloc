Class {
	#name : 'BlEndAlignment',
	#superclass : 'BlRelativeAlignment',
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
