Class {
	#name : #BlMobileCamera,
	#superclass : #BlMobileSubElement,
	#category : 'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #'as yet unclassified' }
BlMobileCamera >> createGradientPaint [
	^ BlLinearGradientPaint new
		stops:
			{(0.0 -> (Color white alpha: 0.7)).
			(0.30 -> (Color veryDarkGray alpha: 0.3)).
			(0.60 -> (Color veryDarkGray alpha: 0.3)).
			(1.0 -> (Color white alpha: 0.7))};
		start: 0 @ BlMobilePhone pxCameraDiameter;
		end: BlMobilePhone pxCameraDiameter @ 0;
		yourself
]

{ #category : #initialization }
BlMobileCamera >> initialize [
	super initialize.
	self geometry: BlEllipse new.
	self background: self createGradientPaint.
	self border: (BlBorder 
		paint: Color black lighter 
		width: (BlMobilePhone pxCameraDiameter * 0.2) asInteger).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self size:  BlMobilePhone pxCameraDiameter asPoint
]
