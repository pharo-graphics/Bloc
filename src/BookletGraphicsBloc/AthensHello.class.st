Class {
	#name : #AthensHello,
	#superclass : #Morph,
	#instVars : [
		'surface'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #'instance creation' }
AthensHello class >> open [
	<example>
	self new openInWindow
]

{ #category : #adding }
AthensHello >> addStringMorph [
	| label transformationMorph|
	
	label := StringMorph
		contents: 'Hello world from Morphic'
		font: (LogicalFont familyName: 'Arial' pointSize: 10).
		label color: Color pink.
		label lock.
		
	transformationMorph := TransformationMorph new asFlexOf: label.
	transformationMorph rotationDegrees: 25.0; scale: 2;
		position: self leftCenter + 10.
	self addMorph: transformationMorph.	


]

{ #category : #defaults }
AthensHello >> defaultExtent [
	^ 600@400
]

{ #category : #accessing }
AthensHello >> defaultLabel [
	^ 'Athens Hello'
]

{ #category : #drawing }
AthensHello >> drawOn: aCanvas [
self renderAthens .
surface displayOnMorphicCanvas: aCanvas at: bounds origin.
self renderMorph: aCanvas.

]

{ #category : #geometry }
AthensHello >> extent: aPoint [
	| newExtent |
	newExtent := aPoint rounded.
	(bounds extent closeTo: newExtent)
		ifTrue: [ ^ self ].
	self changed.
	bounds := bounds topLeft extent: newExtent.
	surface := AthensCairoSurface extent: newExtent.
	self layoutChanged.
	self changed
]

{ #category : #initialization }
AthensHello >> initialize [
	super initialize.
	self extent: self defaultExtent.
	surface := AthensCairoSurface extent: self extent.
]

{ #category : #examples }
AthensHello >> open [
	<script: 'self new openInWindow'>
	
]

{ #category : #rendering }
AthensHello >> render [
|font|
font := LogicalFont familyName: 'Arial' pointSize: 10.

	surface drawDuring: [:canvas | 
		"canvas pathTransform loadIdentity."
		surface clear. 
		canvas setPaint: ((LinearGradientPaint from: 50@100  to: 300@200) colorRamp: {  0 -> Color white. 1 -> Color black }).
		canvas drawShape: (50@100 extent: 300@200). 
		canvas setFont: font. 
		canvas setPaint: Color yellow.
		canvas pathTransform translateX: 50 Y: 100 + (font getPreciseAscent).
		canvas drawString: 'Hello Athens in Pharo/Morphic'
		
	].

]

{ #category : #rendering }
AthensHello >> renderAthens [
	| font |
	font := LogicalFont familyName: 'Consolas' pointSize: 10.
	surface
		drawDuring: [ :canvas | 
			"canvas pathTransform loadIdentity."
			surface clear.
			canvas
				setPaint:
					((LinearGradientPaint from: 0 @ 0 to: self extent)
						colorRamp:
							{(0 -> Color white).
							(1 -> Color black)}).
			canvas drawShape: (0 @ 0 extent: self extent).
			canvas
				setPaint:
					(canvas surface
						createLinearGradient:
							{(0 -> Color blue).
							(0.5 -> Color white).
							(1 -> Color red)}
						start: 0@200
						stop: 0@400). "change to 200 to get an horizontal gradient"
			canvas drawShape: (0@200 extent: 300@400).
			canvas setFont: font.
			canvas
				setPaint:
					(canvas surface
						createLinearGradient:
							{(0 -> Color blue).
							(0.5 -> Color white).
							(1 -> Color red)}
						start: 50@0
						stop: (37*5)@0). "number of caracter * 5"
			canvas pathTransform
				translateX: 45 Y: 45 + font getPreciseAscent;
				scaleBy: 2;
				rotateByDegrees: 28.
			canvas
				drawString: 'Hello Athens in Pharo/Morphic !!!!!!!'.
			]
]

{ #category : #rendering }
AthensHello >> renderMorph: aCanvas [
|fill rectangle|

	rectangle := Rectangle origin: self leftCenter  corner: self bottomRight.
	
	fill := GradientFillStyle ramp: {0.0 -> Color white. 1.0 -> Color black}.
	fill origin: self leftCenter.
	fill direction: self bottomRight.
	fill normal: self rightCenter .
	fill radial: true.
	aCanvas fillRectangle: rectangle basicFillStyle: fill.

]
