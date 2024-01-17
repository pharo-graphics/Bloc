Class {
	#name : 'BlGridInflexible',
	#superclass : 'BlGridFlexibility',
	#category : 'Bloc-Layout-Grid-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Grid-Utilities'
}

{ #category : 'comparing' }
BlGridInflexible >> and: aFlexibility [
	aFlexibility andInflexible: self
]

{ #category : 'comparing' }
BlGridInflexible >> andCanStretch: aFlexibility [
	^ self
]

{ #category : 'comparing' }
BlGridInflexible >> andInflexible: aFlexibility [
	^ self
]
