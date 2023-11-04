Class {
	#name : #BlGridCanStretch,
	#superclass : #BlGridFlexibility,
	#package : 'Bloc',
	#tag : 'Layout-Grid-Utilities'
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
