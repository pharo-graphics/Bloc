"
# Geometry, Visual, and Layout Bounds Explained

A bound is a territorial limit, a boundary. In terms of a graphical element, it is a space in which the graphical element is rendered. For simplicity, bounds are rectangular areas. Bloc defines three different bounds (layout, geometry, and visual) that we will explain using the following example:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#centeredOutskirts|previewExpanded}}

""Layout"" bounds are drawn with gray dashed rectangles in the figure above. They are of this size in this particula example, because each element defines its size explicitly using `size:` method. Layout bounds are considered by layout algorithms to define mutual locations for all considered elements.

""Geometry"" bounds are drawn with red dashed rectangles in the figure above. The area is defined by minimum and maximum values of a polygon vertices. In case of rectangle, geometry bounds are defined by the following polygon:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#rectanglePolygon}}

""Visual"" bounds are drawn with blue rectangles in the figure above. It is an exact area occupied by an element. Computing visual bounds is the most expensive computation as it takes strokes and rendering into account.

## Different Bounds Setups

The first figure above draws all strokes centered around the defined vertices. For that reason, the geometry bounds are in the middle. The following example draws strokes outside:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#outsideOutskirts|previewExpanded}}

In case of the rectangle, you can notice that its stroke is inside of the visual (blue, outside) and the geometry (red, inside) bounds. If the strokes are drawn inside, then visual and geometry bounds are equal:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#insideOutskirts|previewExpanded}}

## Clipping

Geometry is used to define clipping. Consider the below an example in which the triangle is placed in the green parent. When clipping is `false`, the triangle is seen in its entirety.

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#unclippedTriangle|previewExpanded=}}

When clipping is true, the triangle is cut.

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#clippedTriangle|previewExpanded=}}


# Debugging Bounds

Being able to display those three bounds helps when elements are not visually aligned as expected. Consider the following example:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#misalignedIcon|previewExpanded}}

The triangle (icon) and text are not vertically centered despide the fact that we have `BlLinearLayout horizontal alignCenter` in the code. To understand why it happens, `aTriangleElement debug: true` can be added to the code with the following result:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#debuggingMisalignedIcon|previewExpanded}}

As we can see the layout bounds (gray dashed rectangle) consider larger area then expected. Looking at the definition of the triangle polygon, we can spot that the polygon starts at `0@3` instead of `0@0`: 

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#misalignedTrianglePolygon}}

If we fix it to: 

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#trianglePolygon}}

The icon and text are aligned as expected:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#debuggingAlignedIcon|previewExpanded}}

And we can disactivate the debug mode:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#alignedIcon|previewExpanded}}

The debugging mode is also possible to activate in the GT-Inspector's menu, next to the tabs.

"
Class {
	#name : #BlGeometryVisualAndLayoutBoundsExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> alignedIcon [

	<sampleInstance>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement geometry: self trianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement addChildren: {
			anIconElement.
			aLabelElement }.
	^ aContainerElement
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> centeredOutskirts [
	"Rectangle and star elements with centered stroke"

	<sampleInstance>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryCentered.
	aContainer addChild: self starWithSmallerGeometryCentered.

	^ aContainer
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> clippedTriangle [
	"Clipped triangle polygon with layout bounds"

	<sampleInstance>
	| aContainer |
	aContainer := self unclippedTriangle.
	aContainer clipChildren: true.
	^ aContainer
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> container [
	"A container for the rectangle and the star"

	<sampleInstance>
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

	<sampleInstance>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	^ aContainerElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMisalignedIcon [

	<sampleInstance>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first.
	^ aContainerElement
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMode [
	"Triangle polygon with visual and geometry bounds"

	<sampleInstance>
	| aContainer |
	aContainer := self fullyVisibleTriangle.
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> emptyIconElement [

	<sampleInstance>
	^ BlDevElement new
		  extent: 8 @ 12;
		  background: Color green muchDarker;
		  yourself
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> fullyVisibleTriangle [
	"Fully visible triangle polygon that exceeds layout bounds"

	<sampleInstance>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer position: 30 @ 30.
	^ aContainer
]

{ #category : #geometries }
BlGeometryVisualAndLayoutBoundsExamples >> histogram [
	<sampleInstance>
	<demo>
	
	| ramp orientations colors width height gap container |
	ramp := (0 to: 1 by: 0.2).
	orientations := #(beHorizontal beHorizontalInverted beVertical beVerticalInverted).
	colors := Color wheel: orientations size.
	width := 150.
	height := 100.
	gap := 10.

	container := BlElement new.
	container extent: gap + (orientations size * (width + gap)) @ (50 + height).
	container layout: (BlLinearLayout new cellSpacing: gap; yourself).

	orientations withIndexDo: [ :each :index |
			| cell g |
			cell := BlElement new.
			cell clipChildren: false.
			cell layout: BlLinearLayout vertical.
			cell border: (BlBorder paint: Color black width: 0.5).
			cell margin: (BlInsets vertical: gap).
			cell constraintsDo: [:c |
				c horizontal fitContent.
				c vertical fitContent ].
			
			g := BlHistogramGeometry values: ramp.
			g perform: each.

			cell addChild: (BlElement new
				border: (BlBorder paint: Color black width: 1);
				width: width;
				height: height;
				background: (colors at: index);
				geometry: g;
				yourself).

			cell addChild: (BlTextElement new
				text: each asString asRopedText;
				editorMeasurement;
				constraintsDo: [:c | c linear horizontal alignCenter ];
				yourself).

			container addChild: cell ].

	^ container
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> iconAndTextContainer [

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

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> insideOutskirts [
	"Rectangle and star elements with inside stroke"

	<sampleInstance>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.

	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedIcon [

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

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedTrianglePolygon [
	"Triangle polygon"

	<sampleInstance>
	^ BlPolygonGeometry vertices: {
			  (0 @ 3).
			  (8 @ 7.5).
			  (0 @ 12) }
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> outsideOutskirts [
	"Rectangle and star elements with outside stroke"

	<sampleInstance>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.

	^ aContainer
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectanglePolygon [
	"Rectangle polygon"

	<sampleInstance>
	^ BlPolygonGeometry vertices: {
			  (50 @ 50).
			  (150 @ 50).
			  (150 @ 100).
			  (50 @ 100) }
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometry [
	"Rectangle element in debug mode, displaying bounds"

	<sampleInstance>
	| aRectangleElement |
	aRectangleElement := BlDevElement new.
	aRectangleElement geometry: self rectanglePolygon.
	aRectangleElement extent: 200 @ 150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border:
		(BlBorder paint: (Color gray alpha: 0.5) width: 10).

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryCentered [
	"Rectangle element with centered stroke"

	<sampleInstance>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryInside [
	"Rectangle element with inside stroke"

	<sampleInstance>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryOutside [
	"Rectangle element with outside stroke"

	<sampleInstance>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.

	^ aRectangleElement
]

{ #category : #geometries }
BlGeometryVisualAndLayoutBoundsExamples >> sigmoid [
	<sampleInstance>

	| geometry |
	geometry := BlSigmoidGeometry new from: 0 asPoint to: 100 asPoint; yourself.
	geometry beVertical.

	^ BlElement new
		geometry: geometry;
		border: (BlBorder paint: Color blue width: 3);
		beOutskirtsCentered;
		extent: 100 asPoint;
		yourself
]

{ #category : #geometries }
BlGeometryVisualAndLayoutBoundsExamples >> stadium [
	<sampleInstance>
	<demo>
	
	| extents gap container |
	extents := { 200@100. 100@200. 100@100 }.
	gap := 10.

	container := BlElement new.
	container extent: 600 @ 200.

	container layout: (BlLinearLayout new cellSpacing: gap; yourself).

	extents do: [ :each |
		container addChild: (BlElement new
			extent: each;
			border: (BlBorder paint: Color black width: 2);
			background: Color blue;
			geometry: BlStadiumGeometry new;
			addEventHandlerOn: BlMouseEnterEvent do: [ :evt | evt target opacity: 0.5 ];
			addEventHandlerOn: BlMouseLeaveEvent do: [ :evt | evt target opacity: 1.0 ];
			yourself) ].

	^ container
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starPolygon [
	"Star polygon"

	<sampleInstance>
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

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometry [
	"Star element in debug mode, displaying bounds"

	<sampleInstance>
	| aStarElement |
	aStarElement := BlDevElement new.
	aStarElement geometry: self starPolygon.
	aStarElement extent: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement border:
		(BlBorder paint: (Color gray alpha: 0.5) width: 10).
	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryCentered [
	"Star element with centered stroke"

	<sampleInstance>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.

	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryInside [
	"Star element with inside stroke"

	<sampleInstance>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.

	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryOutside [
	"Star element with outside stroke"

	<sampleInstance>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.

	^ aStarElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> textElementWithRunText [

	<sampleInstance>
	^ BlTextElement new text: 'Run' asRopedText
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> trianglePolygon [
	"Triangle polygon"

	<sampleInstance>
	^ BlPolygonGeometry vertices: {
			  (0 @ 0).
			  (8 @ 6).
			  (0 @ 12) }
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> unclippedTriangle [
	"Clipped triangle polygon with layount bounds"

	<sampleInstance>
	| aContainer aPolygonElement |
	aContainer := BlElement new.
	aContainer extent: 8 @ 11.
	aContainer position: 50 @ 50.
	aContainer clipChildren: false.
	aContainer transformDo: [ :t |
		t origin: BlAffineTransformationTopLeftOrigin new.
		t scaleBy: 10 ].
	aContainer outskirts: BlOutskirts centered.
	aContainer border:
		(BlBorder paint: (Color green alpha: 0.4) width: 0.2).

	aPolygonElement := BlElement new.
	aPolygonElement extent: 8 @ 11.
	aPolygonElement geometry: (BlPolygonGeometry vertices: {
				 (0 @ 0).
				 (8 @ 5.5).
				 (0 @ 11) }).
	aPolygonElement border:
		(BlBorder paint: (Color gray alpha: 0.4) width: 2).
	aPolygonElement outskirts: BlOutskirts centered.

	aContainer addChild: aPolygonElement.

	^ aContainer
]
