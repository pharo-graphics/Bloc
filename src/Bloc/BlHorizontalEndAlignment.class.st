Class {
	#name : 'BlHorizontalEndAlignment',
	#superclass : 'Object',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlHorizontalEndAlignment class >> leftToRight [
	^ self right
]

{ #category : 'factory' }
BlHorizontalEndAlignment class >> rightToLeft [
	^ self left
]

{ #category : 'factory' }
BlHorizontalEndAlignment >> inverted [
	^ BlElementAlignment vertical end
]

{ #category : 'factory' }
BlHorizontalEndAlignment >> swap [
	^ BlElementAlignment horizontal start
]
