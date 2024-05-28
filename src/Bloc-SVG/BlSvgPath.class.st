"
I am the `BlElementVectorGeometry` used to represent a SVG Path, which allows to make complex drawings.

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
		'fillRule',
		'pathString'
	],
	#classVars : [
		'EvenOdd',
		'Winding'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'class initialization' }
BlSvgPath class >> initialize [

	EvenOdd := #evenOdd.
	Winding := #winding
]

{ #category : #'instance creation' }
BlSvgPath class >> pathString: aString [
	
	^ self new
		pathString: aString;
		yourself
]

{ #category : #converting }
BlSvgPath >> asElement [
	"Answer the default element for this geometry. The answer should comply the SVG default style."

	^ super asElement
		background: Color black;
		border: BlBorder empty;
		yourself
]

{ #category : #'geometry testing' }
BlSvgPath >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	
	self flag: #todo. "refine! should have a boolean flag to deknow if it's filled?"
	
	^ true
]

{ #category : #initialization }
BlSvgPath >> initialize [

	super initialize.

	self useWindingFillRule
]

{ #category : #accessing }
BlSvgPath >> matchExtent: anExtent [
	"Ignored"
]

{ #category : #'instance creation' }
BlSvgPath >> pathString: aString [

	pathString := aString.
	self releaseCache
]

{ #category : #accessing }
BlSvgPath >> useEvenOddFillRule [

	fillRule := EvenOdd
]

{ #category : #accessing }
BlSvgPath >> useWindingFillRule [

	fillRule := Winding
]
