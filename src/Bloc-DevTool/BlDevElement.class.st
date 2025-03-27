"
I am an element that draws 3 different kinds of bounds that all elements have.


* dashed red:  self geometryBounds
* solid blue:  self visualBounds
* dashed gray: self bounds inLocal

"
Class {
	#name : #BlDevElement,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #drawing }
BlDevElement >> aeDrawDebugInfoOn: aeCanvas [

	| aWidth |
	aWidth := (self globalBoundsToLocal: (BlBounds origin: 0@0 extent: 1@1)) width.

	aeCanvas
		pathFactory: [ :context |
			context rectangle: self geometryBounds ];
		setBackgroundOff;
		setOutskirtsOutside;
		setBorderBlock: [
			aeCanvas
				setSourceColor: (Color red alpha: 0.5);
				setDashes: { aWidth * 6 . aWidth * 6 } offset: 0;
				setBorderWidth: aWidth ];
		drawFigure.

	aeCanvas
		pathFactory: [ :context |
			context rectangle: self visualBounds ];
		setBackgroundOff;
		setOutskirtsOutside;
		setBorderBlock: [
			aeCanvas
				setSourceColor: (Color blue alpha: 0.5);
				setDashes: #() offset: 0;
				setBorderWidth: aWidth ];
		drawFigure.

	aeCanvas
		pathFactory: [ :context |
			context rectangle: self bounds inLocal asRectangle ];
		setBackgroundOff;
		setOutskirtsOutside;
		setBorderBlock: [
			aeCanvas
				setSourceColor: (Color gray alpha: 0.5);
				setDashes: { aWidth * 6 . aWidth * 6 } offset: 0;
				setBorderWidth: aWidth ];
		drawFigure
]

{ #category : #drawing }
BlDevElement >> aeDrawOn: aeCanvas [

	super aeDrawOn: aeCanvas.

	self aeDrawDebugInfoOn: aeCanvas
]

{ #category : #'geometry bounds' }
BlDevElement >> computeInvalidationBoundsInto: aBounds [

	| anInvalidationBounds |
	anInvalidationBounds := super computeInvalidationBoundsInto: aBounds.

	"Save a small margin to draw my borders"
	anInvalidationBounds expandBy: 1.

	^ anInvalidationBounds
]
