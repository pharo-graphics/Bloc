"
I am the `BlElementVectorGeometry` used to represent a SVG path.

A SVG Path is obtained through successives commands, which each symbolizes a movement of the virtual pen drawing the path.

Given a String with a SVG path definition, I collaborate with a parser to generate a sequence of path commands, that will be used to render.
"
Class {
	#name : #BlSvgPath2,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'commands',
		'pathString'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlSvgPath2 class >> pathString: aString [
	
	^ self new
		pathString: aString;
		yourself
]

{ #category : #converting }
BlSvgPath2 >> asElement [
	"Answer the default element for this geometry. The answer should comply the SVG default style."

	^ super asElement
		background: Color black;
		border: BlBorder empty;
		yourself
]

{ #category : #'geometry testing' }
BlSvgPath2 >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	
	self flag: #todo. "refine! should have a boolean flag to deknow if it's filled?"
	
	^ true
]

{ #category : #testing }
BlSvgPath2 >> hasCaps [
	"The purpose of answering false is optimization. For a simplified implementation, always set caps."

	^ true
]

{ #category : #testing }
BlSvgPath2 >> hasJoins [
	"The purpose of answering false is optimization. For a simplified implementation, always set joins."

	^ true
]

{ #category : #geometry }
BlSvgPath2 >> matchExtent: anExtent [
	"Ignored"
]

{ #category : #accessing }
BlSvgPath2 >> pathString: aString [

	| handler |
	pathString := aString.

	handler := BlSvgPathCanvasCommandHandler new.
	(BlSvgPathParser
		on: pathString readStream
		handler: handler)
		readUpToEnd.
	commands := handler commands
]
