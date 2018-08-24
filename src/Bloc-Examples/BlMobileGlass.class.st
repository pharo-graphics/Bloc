Class {
	#name : #BlMobileGlass,
	#superclass : #BlMobileSubElement,
	#category : 'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #'as yet unclassified' }
BlMobileGlass >> createGradientPaint [
	^ BlLinearGradientPaint new
		stops:
			{(0.0 -> (Color transparent)).
			(0.70 -> (Color black alpha: 0.05)).
			(0.71 -> (Color white alpha: 0.05)).
			(1 -> (Color white alpha: 0.05)).};
		start: 0 @ (BlMobilePhone pxBodyHeight/2.7) ;
		end: (BlMobilePhone pxBodyWidth*4) @ BlMobilePhone pxBodyHeight /4.5;
		yourself
]

{ #category : #initialization }
BlMobileGlass >> initialize [
	super initialize.
	self background: self createGradientPaint.
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]
