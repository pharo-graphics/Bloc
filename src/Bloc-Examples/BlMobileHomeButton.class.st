Class {
	#name : #BlMobileHomeButton,
	#superclass : #BlMobileSubElement,
	#category : #'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #'as yet unclassified' }
BlMobileHomeButton >> createGradientPaint [
	^ BlLinearGradientPaint new
		stops: { 
		0.0 -> (Color white alpha:0.7).
		0.30 -> (Color veryDarkGray alpha:0.3).
		0.60 -> (Color veryDarkGray alpha:0.3).
		1.0 -> (Color white alpha:0.7) };
		start: 0@BlMobilePhone pxHomeButtonDiameter;
		end: BlMobilePhone pxHomeButtonDiameter@0;
		yourself
]

{ #category : #initialization }
BlMobileHomeButton >> initialize [
	super initialize.
	self geometry: BlEllipseGeometry new.
	self background: Color black.
	self border: (BlBorder paint: self createGradientPaint width: 3).
	self margin: (BlInsets top: BlMobilePhone pxHomeButtonTopMargin ).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self size:  BlMobilePhone pxHomeButtonDiameter asPoint
]
