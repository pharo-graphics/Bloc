Class {
	#name : #BlHorizontalStartAlignment,
	#superclass : #BlHorizontalAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : 'class initialization' }
BlHorizontalStartAlignment class >> initialize [
	super initialize.
]

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
