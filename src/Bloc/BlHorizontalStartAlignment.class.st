Class {
	#name : 'BlHorizontalStartAlignment',
	#superclass : 'Object',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlHorizontalStartAlignment class >> leftToRight [
	^ self left
]

{ #category : 'factory' }
BlHorizontalStartAlignment class >> rightToLeft [
	^ self right
]

{ #category : 'factory' }
BlHorizontalStartAlignment >> inverted [
	^ BlElementAlignment vertical start
]

{ #category : 'factory' }
BlHorizontalStartAlignment >> swap [
	^ BlElementAlignment horizontal end
]
