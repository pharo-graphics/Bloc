Class {
	#name : #BlHorizontalEndAlignment,
	#superclass : #BlHorizontalAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlHorizontalEndAlignment class >> initialize [
	super initialize.
]

{ #category : #factory }
BlHorizontalEndAlignment class >> leftToRight [
	^ self right
]

{ #category : #factory }
BlHorizontalEndAlignment class >> rightToLeft [
	^ self left
]

{ #category : #factory }
BlHorizontalEndAlignment >> inverted [
	^ BlElementAlignment vertical end
]

{ #category : #factory }
BlHorizontalEndAlignment >> swap [
	^ BlElementAlignment horizontal start
]
