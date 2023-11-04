"
# Forwarded element styles

Extends `BlStyles` by adding an ability to customise `BlForwardedStyles>>#targetObject` on which styles are applied.

"
Class {
	#name : 'BlForwardedStyles',
	#superclass : 'BlStyles',
	#instVars : [
		'targetObject'
	],
	#package : 'Bloc',
	#tag : 'Basic-Style'
}

{ #category : 'private - adding' }
BlForwardedStyles >> newStyleForState: aBlElementState [

	^ BlElementForwardedStyle new
		  state: aBlElementState;
		  targetObject: targetObject
]

{ #category : 'private - adding' }
BlForwardedStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [

	^ styles
		detect: [ :eachStyle |
			eachStyle isForwarded
				and: [ eachStyle targetObject = targetObject
					and: [ eachStyle state = aState ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'accessing' }
BlForwardedStyles >> targetObject [

	^ targetObject
]

{ #category : 'accessing' }
BlForwardedStyles >> targetObject: anObject [

	targetObject := anObject
]
