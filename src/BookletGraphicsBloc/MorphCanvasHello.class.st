Class {
	#name : #MorphCanvasHello,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #'instance creation' }
MorphCanvasHello class >> open [
	<example>
	self new openInWindow
]

{ #category : #adding }
MorphCanvasHello >> addStringMorph [
	| label transformationMorph|
	
	label := StringMorph
		contents: 'Hello world from Morphic'
		font: (LogicalFont familyName: 'Lucida Console' pointSize: 10).
		label color: Color red.
		label lock.
		
	transformationMorph := TransformationMorph new asFlexOf: label.
	transformationMorph rotationDegrees: 25.0; scale: 2;
		position: self leftCenter + 10.
	self addMorph: transformationMorph.	


]

{ #category : #accessing }
MorphCanvasHello >> defaultExtent [
	^ 600@400
]

{ #category : #accessing }
MorphCanvasHello >> defaultLabel [
	^ 'Morph Canvas Hello'
]

{ #category : #drawing }
MorphCanvasHello >> drawAxesOn: aCanvas [
	aCanvas
		line: self topCenter
		to: self bottomCenter
		width: 2
		color: Color black.
	aCanvas
		line: self leftCenter
		to: self rightCenter
		width: 2
		color: Color black.
]

{ #category : #drawing }
MorphCanvasHello >> drawCarretOn: aCanvas [
	0 to: self width by: 10 do: [ :position | 
		self
			drawVerticalCarretOn: aCanvas
			at: (self leftCenter translateBy: position @ 0) ].
	0 to: self height by: 10 do: [ :position | 
		self
			drawHorizontalCarretOn: aCanvas
			at: (self topCenter translateBy: 0 @ position) ]
]

{ #category : #drawing }
MorphCanvasHello >> drawHorizontalCarretOn: aCanvas at: aPosition [
	aCanvas
		line: (aPosition translateBy: -5 @ 0)
		to: (aPosition translateBy: 5 @ 0)
		width: 2
		color: Color black
]

{ #category : #drawing }
MorphCanvasHello >> drawOn: aCanvas [

	self renderMorph: aCanvas.
	aCanvas fillColor: Color green.
	self drawAxesOn: aCanvas.
	self drawCarretOn: aCanvas.

]

{ #category : #drawing }
MorphCanvasHello >> drawVerticalCarretOn: aCanvas at: aPosition [
	aCanvas
		line: (aPosition translateBy: 0 @ -5)
		to: (aPosition translateBy: 0 @ 5)
		width: 2
		color: Color black
]

{ #category : #initialization }
MorphCanvasHello >> initialize [
	super initialize.
	self extent: self defaultExtent.
	self addStringMorph.
]

{ #category : #examples }
MorphCanvasHello >> open [
	<script: 'self new openInWindow'>
	
]

{ #category : #rendering }
MorphCanvasHello >> renderMorph: aCanvas [
|fill rectangle|

	rectangle := Rectangle origin: self topLeft  corner: self bottomRight.
	
	fill := GradientFillStyle ramp: {0.0 -> Color white. 1.0 -> Color black}.
	fill origin: self leftCenter.
	fill direction: self bottomRight.
	fill normal: self rightCenter .
	fill radial: true.
	aCanvas fillRectangle: rectangle basicFillStyle: fill.

]
