"
!Forwarded element styles
Extends ${class:BlStyles}$ by adding an ability to customise ${method:BlForwardedStyles>>#targetObject}$ on which styles are applied.
"
Class {
	#name : #BlForwardedStyles,
	#superclass : #BlStyles,
	#instVars : [
		'targetObject'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #'private - adding' }
BlForwardedStyles >> newStyleForState: aBlElementState [
	^ BlElementForwardedStyle new
		state: aBlElementState;
		targetObject: self targetObject
]

{ #category : #'private - adding' }
BlForwardedStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		detect: [ :eachStyle |
			eachStyle isForwarded
				and: [ eachStyle targetObject = self targetObject
					and: [ eachStyle state = aState ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
BlForwardedStyles >> targetObject [
	^ targetObject
]

{ #category : #accessing }
BlForwardedStyles >> targetObject: anObject [
	targetObject := anObject
]
