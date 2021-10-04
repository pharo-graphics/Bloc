"
# Forwarded element styles
Extends {{gtClass:BlElementStyles}} by adding an ability to customise {{gtMethod:BlForwardedElementStyles>>#targetObject}} on which styles are applied.

"
Class {
	#name : #BlForwardedElementStyles,
	#superclass : #BlElementStyles,
	#instVars : [
		'targetObject'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'private - adding' }
BlForwardedElementStyles >> newStyleForState: aBlElementState [
	^ BlElementForwardedStyle new
		state: aBlElementState;
		targetObject: self targetObject
]

{ #category : #'private - adding' }
BlForwardedElementStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle |
			eachStyle isForwarded
				and: [ eachStyle targetObject = self targetObject
					and: [ eachStyle state = aState ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
BlForwardedElementStyles >> targetObject [
	^ targetObject
]

{ #category : #accessing }
BlForwardedElementStyles >> targetObject: anObject [
	targetObject := anObject
]
