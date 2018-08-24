"
(IceRepository repositoriesLocation / 'pharo-graphics'/ 'bloc' / 'doc' / 'bounds' / 'bounds-types.pillar') inspect
"
Class {
	#name : #BlGeometryVisualAndLayoutBoundsExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'Bloc-Examples-Basic'
}

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> alignedIcon [
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

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> centeredOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with centered stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryCentered.
	aContainer addChild: self starWithSmallerGeometryCentered.

	^ aContainer
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> clippedTriangle [
	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
	| aContainer aPolygonElement |
	aContainer := BlElement new.
	aContainer size: 8@11.
	aContainer relocate: 20@20.
	aContainer clipChildren: true.
	aContainer transformDo: [ :t |
	    t origin: BlAffineTransformationTopLeftOrigin new.
	    t scaleBy: 10 ].
	aContainer outskirts: BlOutskirts centered.
	aContainer border: (BlBorder paint: (Color green alpha: 0.4) width: 0.2).

	aPolygonElement := BlElement new.
	aPolygonElement size: 8@11.
	aPolygonElement geometry: (BlPolygon vertices: { 0@0 . 8@5.5. 0@11 }).
	aPolygonElement border: (BlBorder paint: (Color gray alpha: 0.4) width: 2).
	aPolygonElement outskirts: BlOutskirts centered.

	aContainer addChild: aPolygonElement.

	^ aContainer
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> container [
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

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingAlignedIcon [
	<gtExample>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	aContainerElement children first debug: true.
	^ aContainerElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMisalignedIcon [
	<gtExample>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first debug: true.
	^ aContainerElement
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMode [
	<gtExample>
	<label: 'Triangle polygon with visual and geometry bounds'>
	| aContainer aTriangleElement |
	aContainer := self fullyVisibleTriangle.
	aTriangleElement := aContainer children first.
	aTriangleElement debug: true.
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> emptyIconElement [
	<gtExample>
	^ BlElement new
		size: 8 @ 12;
		background: Color green muchDarker.
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> fullyVisibleTriangle [
	<gtExample>
	<label: 'Fully visible triangle polygon that exceeds layout bounds'>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer relocate: 30@30.
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> iconAndTextContainer [
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

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> insideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with inside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.
		
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedIcon [
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

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedTrianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	^ BlPolygon
		vertices:
			{(0 @ 3).
			(8 @ 7.5).
			(0 @ 12)}
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> outsideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with outside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.
		
	^ aContainer
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectanglePolygon [
	<gtExample>
	<label: 'Rectangle polygon'>
	^ BlPolygon vertices: {
		(50@50). (150@50). (150@100). (50@100)
	}
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometry [
	<gtExample>
	<label: 'Rectangle element in debug mode, displaying bounds'>
	| aRectangleElement |
	
	aRectangleElement := BlElement new.
	aRectangleElement geometry: self rectanglePolygon.
	aRectangleElement size: 200@150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	aRectangleElement debug: true.
	
	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Rectangle element with centered stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.
	
	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryInside [
	<gtExample>
	<label: 'Rectangle element with inside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.
	
	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Rectangle element with outside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.
	
	^ aRectangleElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starPolygon [
	<gtExample>
	<label: 'Star polygon'>
	^ BlPolygon
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

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometry [
	<gtExample>
	<label: 'Star element in debug mode, displaying bounds'>
	| aStarElement |
	aStarElement := BlElement new.
	aStarElement geometry: self starPolygon.
	aStarElement size: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	aStarElement debug: true.
	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Star element with centered stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.
	
	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryInside [
	<gtExample>
	<label: 'Star element with inside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.
	
	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Star element with outside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.
	
	^ aStarElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> textElementWithRunText [
	<gtExample>
	^ BlTextElement new text: 'Run' asRopedText
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> trianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	^ BlPolygon
		vertices:
			{(0 @ 0).
			(8 @ 6).
			(0 @ 12)}
]
