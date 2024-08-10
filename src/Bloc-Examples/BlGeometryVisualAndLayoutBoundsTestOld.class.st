"
I have been automatically converted and probably manually tweaked from BlGeometryVisualAndLayoutBoundsExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlGeometryVisualAndLayoutBoundsTestOld,
	#superclass : #TestCase,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples'
}

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testAlignedIcon [

	| anIconElement aLabelElement aContainerElement |
	anIconElement := self testEmptyIconElement geometry:
		                 self testTrianglePolygon.
	aLabelElement := self testTextElementWithRunText.
	aContainerElement := self testIconAndTextContainer.
	aContainerElement addChildren: {
			anIconElement.
			aLabelElement }.
	^ aContainerElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testCenteredOutskirts [
	"Rectangle and star elements with centered stroke"

	| aContainer |
	aContainer := self testContainer.
	aContainer addChild: self testRectangleWithSmallerGeometryCentered.
	aContainer addChild: self testStarWithSmallerGeometryCentered.

	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testClippedTriangle [

	<sampleInstance>
	"Clipped triangle polygon with layount bounds"
	| aContainer |
	aContainer := self testUnclippedTriangle.
	aContainer clipChildren: true.
	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testContainer [

	<sampleInstance>
	<label: 'A container for the rectangle and the star'>
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: (BlGridLayout horizontal cellSpacing: 20).
	aContainer margin: (BlInsets all: 10).
	aContainer padding: (BlInsets all: 10).
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testDebuggingAlignedIcon [

	<sampleInstance>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	^ aContainerElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testDebuggingMisalignedIcon [

	<sampleInstance>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first.
	^ aContainerElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testDebuggingMode [

	<sampleInstance>
	<label: 'Triangle polygon with visual and geometry bounds'>
	| aContainer |
	aContainer := self fullyVisibleTriangle.
	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testEmptyIconElement [

	<sampleInstance>
	^ BlDevElement new
		  size: 8 @ 12;
		  background: Color green muchDarker
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testFullyVisibleTriangle [

	<sampleInstance>
	<label: 'Fully visible triangle polygon that exceeds layout bounds'>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer position: 30 @ 30.
	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testIconAndTextContainer [

	<sampleInstance>
	| aContainerElement |
	aContainerElement := BlElement new
		                     layout: BlLinearLayout horizontal alignCenter;
		                     constraintsDo: [ :c |
			                     c horizontal fitContent.
			                     c vertical fitContent ];
		                     background: (Color gray alpha: 0.3);
		                     padding: (BlInsets all: 3);
		                     margin: (BlInsets left: 5).
	aContainerElement transformDo: [ :t |
		t origin: BlAffineTransformationTopLeftOrigin new.
		t scaleBy: 5 ].
	^ aContainerElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testInsideOutskirts [

	<sampleInstance>
	<label: 'Rectangle and star elements with inside stroke'>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.

	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testMisalignedIcon [

	<sampleInstance>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement geometry:
		                 self misalignedTrianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement addChildren: {
			anIconElement.
			aLabelElement }.
	^ aContainerElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testMisalignedTrianglePolygon [

	<sampleInstance>
	<label: 'Triangle polygon'>
	^ BlPolygonGeometry vertices: {
			  (0 @ 3).
			  (8 @ 7.5).
			  (0 @ 12) }
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testOutsideOutskirts [

	<sampleInstance>
	<label: 'Rectangle and star elements with outside stroke'>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.

	^ aContainer
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testRectanglePolygon [

	<sampleInstance>
	<label: 'Rectangle polygon'>
	^ BlPolygonGeometry vertices: {
			  (50 @ 50).
			  (150 @ 50).
			  (150 @ 100).
			  (50 @ 100) }
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testRectangleWithSmallerGeometry [

	<sampleInstance>
	<label: 'Rectangle element in debug mode, displaying bounds'>
	| aRectangleElement |
	aRectangleElement := BlDevElement new.
	aRectangleElement geometry: self testRectanglePolygon.
	aRectangleElement size: 200 @ 150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border:
		(BlBorder paint: (Color gray alpha: 0.5) width: 10).

	^ aRectangleElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testRectangleWithSmallerGeometryCentered [
	"Rectangle element with centered stroke"

	| aRectangleElement |
	aRectangleElement := self testRectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.

	^ aRectangleElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testRectangleWithSmallerGeometryInside [

	<sampleInstance>
	<label: 'Rectangle element with inside stroke'>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.

	^ aRectangleElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testRectangleWithSmallerGeometryOutside [

	<sampleInstance>
	<label: 'Rectangle element with outside stroke'>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.

	^ aRectangleElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testStarPolygon [

	^ BlPolygonGeometry vertices: {
			  (100 @ 50).
			  (115 @ 90).
			  (150 @ 90).
			  (125 @ 110).
			  (135 @ 150).
			  (100 @ 130).
			  (65 @ 150).
			  (75 @ 110).
			  (50 @ 90).
			  (85 @ 90) }
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testStarWithSmallerGeometry [
	"Star element in debug mode, displaying bounds"

	| aStarElement |
	aStarElement := BlDevElement new.
	aStarElement geometry: self testStarPolygon.
	aStarElement size: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement border:
		(BlBorder paint: (Color gray alpha: 0.5) width: 10).
	^ aStarElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testStarWithSmallerGeometryCentered [

	<sampleInstance>
	"Star element with centered stroke"
	| aStarElement |
	aStarElement := self testStarWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.

	^ aStarElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testStarWithSmallerGeometryInside [

	<sampleInstance>
	<label: 'Star element with inside stroke'>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.

	^ aStarElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testStarWithSmallerGeometryOutside [

	<sampleInstance>
	<label: 'Star element with outside stroke'>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.

	^ aStarElement
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testTextElementWithRunText [

	^ BlTextElement new text: 'Run' asRopedText
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testTrianglePolygon [

	^ BlPolygonGeometry vertices: {
			  (0 @ 0).
			  (8 @ 6).
			  (0 @ 12) }
]

{ #category : #tests }
BlGeometryVisualAndLayoutBoundsTestOld >> testUnclippedTriangle [
	"Clipped triangle polygon with layount bounds"

	| aContainer aPolygonElement |
	aContainer := BlElement new.
	aContainer size: 8 @ 11.
	aContainer position: 50 @ 50.
	aContainer clipChildren: false.
	aContainer transformDo: [ :t |
		t origin: BlAffineTransformationTopLeftOrigin new.
		t scaleBy: 10 ].
	aContainer outskirts: BlOutskirts centered.
	aContainer border:
		(BlBorder paint: (Color green alpha: 0.4) width: 0.2).

	aPolygonElement := BlElement new.
	aPolygonElement size: 8 @ 11.
	aPolygonElement geometry: (BlPolygon vertices: {
				 (0 @ 0).
				 (8 @ 5.5).
				 (0 @ 11) }).
	aPolygonElement border:
		(BlBorder paint: (Color gray alpha: 0.4) width: 2).
	aPolygonElement outskirts: BlOutskirts centered.

	aContainer addChild: aPolygonElement.

	^ aContainer
]
