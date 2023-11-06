Class {
	#name : #BlGeometryVisualAndLayoutBoundsExamplesDemo,
	#superclass : #BlExampleTest,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> alignedIcon [
	<gtExample>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement
		geometry: self trianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren:
			{anIconElement.
			aLabelElement}.
	^ aContainerElement
]

{ #category : #'rectangle and start - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> centeredOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with centered stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryCentered.
	aContainer addChild: self starWithSmallerGeometryCentered.

	^ aContainer
]

{ #category : #'bounds - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> clippedTriangle [
	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
	| aContainer |
	aContainer := self unclippedTriangle.
	aContainer clipChildren: true.
	^ aContainer
]

{ #category : #'rectangle and start - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> container [
	<gtExample>
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

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> debuggingAlignedIcon [
	<gtExample>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	^ aContainerElement
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> debuggingMisalignedIcon [
	<gtExample>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first.
	^ aContainerElement
]

{ #category : #'bounds - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> debuggingMode [
	<gtExample>
	<label: 'Triangle polygon with visual and geometry bounds'>
	| aContainer |
	aContainer := self fullyVisibleTriangle.
	^ aContainer
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> emptyIconElement [
	<gtExample>
	^ BlDevElement new
		size: 8 @ 12;
		background: Color green muchDarker.
]

{ #category : #'bounds - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> fullyVisibleTriangle [

	<gtExample>
	<label: 'Fully visible triangle polygon that exceeds layout bounds'>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer position: 30 @ 30.
	^ aContainer
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> iconAndTextContainer [
	<gtExample>
	| aContainerElement |
	aContainerElement := BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.3);
		padding: (BlInsets all: 3);
		margin: (BlInsets left: 5).
	aContainerElement
		transformDo: [ :t | 
			t origin: BlAffineTransformationTopLeftOrigin new.
			t scaleBy: 5 ].
	^ aContainerElement
]

{ #category : #'rectangle and start - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> insideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with inside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.
		
	^ aContainer
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> misalignedIcon [
	<gtExample>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement
		geometry: self misalignedTrianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren:
			{anIconElement.
			aLabelElement}.
	^ aContainerElement
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> misalignedTrianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	^ BlPolygonGeometry 
		vertices:
			{(0 @ 3).
			(8 @ 7.5).
			(0 @ 12)}
]

{ #category : #'rectangle and start - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> outsideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with outside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.
		
	^ aContainer
]

{ #category : #'rectangle - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> rectanglePolygon [
	<gtExample>
	<label: 'Rectangle polygon'>
	^ BlPolygonGeometry vertices: {
		(50@50). (150@50). (150@100). (50@100)
	}
]

{ #category : #'rectangle - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> rectangleWithSmallerGeometry [
	<gtExample>
	<label: 'Rectangle element in debug mode, displaying bounds'>
	| aRectangleElement |
	
	aRectangleElement := BlDevElement new.
	aRectangleElement geometry: self rectanglePolygon.
	aRectangleElement size: 200@150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	
	^ aRectangleElement
]

{ #category : #'rectangle - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> rectangleWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Rectangle element with centered stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.
	
	^ aRectangleElement
]

{ #category : #'rectangle - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> rectangleWithSmallerGeometryInside [
	<gtExample>
	<label: 'Rectangle element with inside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.
	
	^ aRectangleElement
]

{ #category : #'rectangle - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> rectangleWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Rectangle element with outside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.
	
	^ aRectangleElement
]

{ #category : #'star - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> starPolygon [
	<gtExample>
	<label: 'Star polygon'>
	^ BlPolygonGeometry
		vertices:
			{(100 @ 50).
			(115 @ 90).
			(150 @ 90).
			(125 @ 110).
			(135 @ 150).
			(100 @ 130).
			(65 @ 150).
			(75 @ 110).
			(50 @ 90).
			(85 @ 90)}
]

{ #category : #'star - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> starWithSmallerGeometry [
	<gtExample>
	<label: 'Star element in debug mode, displaying bounds'>
	| aStarElement |
	aStarElement := BlDevElement new.
	aStarElement geometry: self starPolygon.
	aStarElement size: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	^ aStarElement
]

{ #category : #'star - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> starWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Star element with centered stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.
	
	^ aStarElement
]

{ #category : #'star - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> starWithSmallerGeometryInside [
	<gtExample>
	<label: 'Star element with inside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.
	
	^ aStarElement
]

{ #category : #'star - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> starWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Star element with outside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.
	
	^ aStarElement
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> textElementWithRunText [
	<gtExample>
	^ BlTextElement new text: 'Run' asRopedText
]

{ #category : #'debugging triangle and text - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> trianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	^ BlPolygonGeometry 
		vertices:
			{(0 @ 0).
			(8 @ 6).
			(0 @ 12)}
]

{ #category : #'bounds - demo' }
BlGeometryVisualAndLayoutBoundsExamplesDemo >> unclippedTriangle [

	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
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
