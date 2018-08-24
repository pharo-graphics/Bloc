Class {
	#name : #BlGridCanStretch,
	#superclass : #BlGridFlexibility,
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #comparing }
BlGridCanStretch >> and: aFlexibility [
	aFlexibility andCanStretch: self
]

{ #category : #comparing }
BlGridCanStretch >> andCanStretch: aFlexibility [
	^ self
]

{ #category : #comparing }
BlGridCanStretch >> andInflexible: aFlexibility [
	^ aFlexibility
]
