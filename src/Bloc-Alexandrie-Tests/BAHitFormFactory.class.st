"
My only purpose is creating a Form from a BlSpace, where each pixel tells what BlElement (or nil) would be hitted by the mouse pointer.
"
Class {
	#name : 'BAHitFormFactory',
	#superclass : 'Object',
	#category : 'Bloc-Alexandrie-Tests-Utilities',
	#package : 'Bloc-Alexandrie-Tests',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
BAHitFormFactory class >> newFormFor: aSpace [

	| allElements colors colorByElement aForm |
	allElements := aSpace root withAllChildrenBreadthFirst.

	colors := { Color white }, (Color wheel: allElements size - 1).
	colorByElement := IdentityDictionary newFromKeys: allElements andValues: colors.
	aForm := Form extent: aSpace extent depth: 32.
	
	1 to: aSpace width do: [ :x |
		1 to: aSpace height do: [ :y |
			| eachPosition hittedElementOrNil hittedColor |
			eachPosition := x@y.
			hittedElementOrNil := aSpace root findMouseEventTargetAt: eachPosition.
			hittedColor := colorByElement
				at: hittedElementOrNil
				ifAbsent: [ Color black ].
			aForm colorAt: eachPosition put: hittedColor ] ].

	^ aForm
]
