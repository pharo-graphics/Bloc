"
! Rectangle geometry with arrow pointer

The goal of this tutorial is to create an element with an arrow-like pointer in the middle of the top edge, as shown below:
${example:BlRectangleShapeWithArrowExplanation>>#elementWithTopArrowGeometry|noCode|previewShow=gtLiveFor:|previewHeight=250}$

A traditional way to implement such geometry is to create a subclass of ${class:BlGeometry}$,  override ${method:BlGeometry>>#buildPathOnSpartaCanvas:}$ and implement quite cumbersome algorithm that computes the location of each point and then connects those points using ==moveTo:== and ==lineTo:== commands provided by ==PathBuilder==. The problem with such solution is its exponential increase in compolexity each time we would like to parametrize and customize the resulting geometry, for example the size of the arrow or its horizontal position. Even more compex would be to implement the support for positioning the arrow on different edges (e.g. left, bottom) or an ability to have multiple arrows on separate edges.

This is where a ${class:BlVectorShape}$ comes-in handy.

!! Creating a rectangle shape

We will start with creation of the rectangle shape ${class:BlRectangleShape}$:
${example:BlRectangleShapeWithArrowExplanation>>#rectangleShape|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}$

!! Translating the top edge

In order to give the arrow pointing up enough space we should move the top edge of the rectangle down by the length of the arrow. First of all we should ask the rectangle shape to give us its top edge ${method:BlRectangleShape>>#topEdge}$. By default the ==topEdge== of the rectangle is an instance of ${class:BlLineShape}$ which can be translated by sending ${method:BlLineShape>>#moveBy:}$ to the ==topEdge==:
${example:BlRectangleShapeWithArrowExplanation>>#rectangleWithTranslatedTopEdge|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}$

!! Injecting a line inside of the top edge

Next step on our way to the arrow is to inject a line segment equal to the length of the arrow in the middle of the ==topEdge==. It can be done by sending ${method:BlLineShape>>#injectLineAt:length:}$ to the ==topEdge==. Since we want to inject a line right in the middle of the edge we pass ==0.5== as a line location:
${example:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopInjectedLine|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}$

!! Splitting the injected line

We are almost ready to create a rectangular arrow. We just need to split an injected line in half in order to create the top corner of the rectangle. We can do so by sending a ${method:BlLineShape>>#splitAt:}$ to the now middle section of the ==topEdge== which was created by the previous line injection step:
${example:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopPolylineSplitInHalf|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}$

!! Moving the top of the triangle

Once we have everything we need for the arrow triangle we can move it's top up by the length of the arrow. To do so we should send ${method:BlPointShape>>#moveBy:}$ to the connection point of the splitted line in the middle of the ==topEdge==. After doing so we receive the expected vector shape we we can later use together with ${class:BlShapeGeometry}$:
${example:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopArrow|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}$


"
Class {
	#name : #BlRectangleShapeWithArrowExplanation,
	#superclass : #Object,
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> arrowLength [
	^ 30
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> elementWithTopArrowGeometry [
	<gtExample>
	
	^ BlElement new
		geometry: (BlShapeGeometry new shape: (self rectangleWithTopArrow));
		size: 300@200;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color lightGray width: 10)
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleShape [
	<gtExample>
	| aRectangle |
	
	aRectangle := BlRectangleShape rectangle: (50@50 extent: 250@150).

	self assert: aRectangle hasParent not.
	self assert: aRectangle attributes isEmpty.
	self assert: aRectangle shapes size equals: 4.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopArrow [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTopPolylineSplitInHalf.
	aRectangle topEdge middle connection moveBy: 0 @ self arrowLength negated.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopInjectedLine [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTranslatedTopEdge.
	aRectangle topEdge
		injectLineAt: 0.5 length: self arrowLength.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopPolylineSplitInHalf [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTopInjectedLine.
	aRectangle topEdge middle splitAt: 0.5.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTranslatedTopEdge [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleShape.
	aRectangle topEdge moveBy: (0@ self arrowLength).

	^ aRectangle
]
