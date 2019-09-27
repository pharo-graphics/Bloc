Class {
	#name : #BlDragView,
	#superclass : #BlElement,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #'as yet unclassified' }
BlDragView class >> on: aForm [
	^ self new target: aForm
]

{ #category : #'as yet unclassified' }
BlDragView >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: self background fill;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		draw.
			
	aCanvas fill
		paint: target;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		draw.

	aCanvas stroke
		paint: self border;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		width: self border width;
		draw
]

{ #category : #initialization }
BlDragView >> initialize [
	super initialize.
	self border: (BlBorder paint: Color veryLightGray width: 1).
	self background: (Color white).
	self effect: (BlGaussianShadowEffect new color: Color gray; width: 2; offset:2@2)
]

{ #category : #accessing }
BlDragView >> target [
	^ target
]

{ #category : #accessing }
BlDragView >> target: aForm [
	target := aForm asForm. 
	
	self extent: target extent.
]

{ #category : #'as yet unclassified' }
BlDragView >> updateFromCursorPosition: aPosition [
	self position: aPosition - (self extent / 2)
]
