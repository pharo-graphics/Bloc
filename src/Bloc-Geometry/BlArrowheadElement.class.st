"
I am a root class for all arrowheads to be used with curve element.

I listen to border width changes of my parent in order to adapt geometry. That is why I am not intended to work outside of CurveElement context, however I can still be used for the case when arrow size depends on border width of a parent.

In order to have pixel perfect connection of the arrowhead with its curve I am treated differently than other children in CurveElement. I also provide custom draw logic to avoid usage of virual canvas layers that prevents the use of ==Source== composition operator.


"
Class {
	#name : #BlArrowheadElement,
	#superclass : #BlElement,
	#instVars : [
		'borderListener'
	],
	#category : 'Bloc-Geometry-Arrowheads'
}

{ #category : #changes }
BlArrowheadElement >> beForZeroWidth [
	self size: 0@0
]

{ #category : #initialization }
BlArrowheadElement >> defaultOutskirts [
	^ BlOutskirts centered
]

{ #category : #drawing }
BlArrowheadElement >> drawOnSpartaCanvas: aCanvas [
	"Override to avoid creation of new layers"

	self outskirts
		drawBackground: [ self drawBackgroundOnSpartaCanvas: aCanvas ]
		border: [ self drawBorderOnSpartaCanvas: aCanvas ]
		of: self
		onSpartaCanvas: aCanvas
]

{ #category : #'geometry hooks' }
BlArrowheadElement >> geometryChanged [

	self hasParent
		ifFalse: [ ^ self ].

	self handleWidthChanged: self parent border width
]

{ #category : #changes }
BlArrowheadElement >> handleWidthChanged: aWidth [
	"Is sent when the width of a curve changed to a given number.
	Arrowhead should adapt its geometry to match new properties"
	
	aWidth isZero
		ifTrue: [ self beForZeroWidth ]
		ifFalse: [ self onWidthChanged: aWidth ]
]

{ #category : #initialization }
BlArrowheadElement >> initialize [
	super initialize.
	
	borderListener := BlEventHandler
		on: BlElementBorderChangedEvent
		do: [ :anEvent | self handleWidthChanged: anEvent currentTarget border width ]
]

{ #category : #'children hooks' }
BlArrowheadElement >> onAddedToParent [
	super onAddedToParent.
	
	self parent addEventHandler: borderListener.
	self geometryChanged
]

{ #category : #'geometry hooks' }
BlArrowheadElement >> onExtentChanged [
	super onExtentChanged.
	
	self updateMargin
]

{ #category : #'children hooks' }
BlArrowheadElement >> onRemovedFromParent: aParentElement [
	super onRemovedFromParent: aParentElement.
	
	aParentElement removeEventHandler: borderListener
]

{ #category : #changes }
BlArrowheadElement >> onWidthChanged: aNumber [
	"Is sent when the width of a curve changed to a given number.
	Arrowhead should adapt its geometry to match new properties.
	Note: aNumber is never 0"
	
	self subclassResponsibility
]

{ #category : #'geometry hooks' }
BlArrowheadElement >> updateMargin [
	self margin: (BlInsets left: (self visualBounds right - self geometryBounds right))
]
