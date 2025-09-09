Extension { #name : #BlSideBackgroundDecoration }

{ #category : #'*Bloc-Alexandrie' }
BlSideBackgroundDecoration >> aeCairoScaledFontOn: aeCanvas in: anInfiniteElement [

	| fontAndStyleBuilder cairoFontFace |
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	cairoFontFace := fontAndStyleBuilder font asAeCairoFontFace.
	^ aeCanvas scaledFontFor: cairoFontFace size: 12
]

{ #category : #'*Bloc-Alexandrie' }
BlSideBackgroundDecoration >> aeDrawBackgroundOn: aeCanvas in: anInfiniteElement [

	"draw the background beneath "

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext rectangle: (self aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement)  ].
	self background aeApplyTo: aeCanvas.
	aeCanvas setBorderOff.
	aeCanvas drawFigure
]

{ #category : #'*Bloc-Alexandrie' }
BlSideBackgroundDecoration >> aeDrawBeneathOn: aeCanvas in: anInfiniteElement [
	"Update the actual width and draw the background beneath "

	self aeUpdateWidthOn: aeCanvas in: anInfiniteElement.
	aeCanvas restoreContextAfter: [
		self aeDrawBackgroundOn: aeCanvas in: anInfiniteElement ].
	"super sent ensure drawing for item elements"
	super aeDrawBeneathOn: aeCanvas in: anInfiniteElement
]

{ #category : #'*Bloc-Alexandrie' }
BlSideBackgroundDecoration >> aeMeasuredWidthOn: aCanvas in: anInfiniteElement [

	" compute and return the actual width. By default, no computing here 
	but subclasses may redefine me to return the necessary width. "
	^ self actualWidth 
]

{ #category : #'*Bloc-Alexandrie' }
BlSideBackgroundDecoration >> aeUpdateWidthOn: aeCanvas in: anInfiniteElement [

	| width |
	width := self aeMeasuredWidthOn: aeCanvas in: anInfiniteElement.
	width <= self actualWidth ifTrue: [ ^ self ].
	actualWidth := width.
	anInfiniteElement requestLayout
]
