"
I am the {{gtClass:BlElementVectorGeometry}} used to represent a SVG Path, which allows to make complex drawings.

A SVG Path is obtained through successives commands, which each symbolizes a movement of the virtual pen drawing the path.
My instance variable'pathData' stores the list of commands used to obtain my final drawing.

To instanciate myself I use the BlSvgPathConverter class, which will allow me to set my 'pathData' instance variable.
To calculate my extent I use the BlSvgPathExtentResolver class, which calculates my extent when I set my 'pathData' instance variable.

Instance creation examples:
	- BlSvgPath new svg: 'M100,200 C100,100 250,100 250,200 S400,300 400,200' viewbox: (0@0 extent: 4000@400) 

"
Class {
	#name : #BlSvgPath,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'position',
		'viewbox',
		'fillRule',
		'svgPathString'
	],
	#classVars : [
		'EvenOdd',
		'Winding'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlSvgPath class >> build: aBlock [
	^ self new build: aBlock
]

{ #category : #'class initialization' }
BlSvgPath class >> initialize [

	EvenOdd := #evenOdd.
	Winding := #winding
]

{ #category : #accessing }
BlSvgPath >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		fillRule = Winding
			ifTrue: [ cairoContext useFillRuleWinding ]
			ifFalse: [ cairoContext useFillRuleEvenOdd ].
		(BlSvgPathParser
			on: svgPathString readStream
			handler: (BASvgPathDrawHandler on: cairoContext))
			readUpToEnd ]
]

{ #category : #'geometry testing' }
BlSvgPath >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	
	self flag: #todo. "Use cairo isIn:?"
	
	^ true
]

{ #category : #testing }
BlSvgPath >> hasCaps [
	"The purpose of answering false is optimization. For a simplified implementation, always set caps."

	^ true
]

{ #category : #testing }
BlSvgPath >> hasJoins [
	"The purpose of answering false is optimization. For a simplified implementation, always set joins."

	^ true
]

{ #category : #initialization }
BlSvgPath >> initialize [

	super initialize.

	svgPathString := ''.
	self useWindingFillRule
]

{ #category : #accessing }
BlSvgPath >> matchExtent: anExtent [

	extent := anExtent
]

{ #category : #initialization }
BlSvgPath >> svgPathString: aString [

	svgPathString := aString
]

{ #category : #accessing }
BlSvgPath >> useEvenOddFillRule [

	fillRule := EvenOdd
]

{ #category : #accessing }
BlSvgPath >> useWindingFillRule [

	fillRule := Winding
]