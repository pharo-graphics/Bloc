Class {
	#name : #BlInfiniteExampleGalleryImageElement,
	#superclass : #BlElement,
	#instVars : [
		'image',
		'loader',
		'form',
		'itemElement',
		'bitmap'
	],
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #layout }
BlInfiniteExampleGalleryImageElement >> applyLayoutIn: aBounds [
	super applyLayoutIn: aBounds.
	self loadImage
]

{ #category : #initialization }
BlInfiniteExampleGalleryImageElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BlInfiniteExampleGalleryImageElement >> defaultWidth [
	^ 500
]

{ #category : #drawing }
BlInfiniteExampleGalleryImageElement >> drawOnSpartaCanvas: aCanvas [
	| aScale |
	super drawOnSpartaCanvas: aCanvas.
	
	form
		ifNil: [ ^ self ].

	bitmap ifNil: [ bitmap := aCanvas bitmap fromForm: form ].
	
	aScale := (self extent / form extent) asFloatPoint.

	aCanvas transform
		by: [ :t | t scaleBy: aScale ]
		during: [
			aCanvas fill
				path: (0@0 extent: form extent);
				paint: bitmap;
				draw ]
]

{ #category : #accessing }
BlInfiniteExampleGalleryImageElement >> form: aForm [
	
	image form == aForm
		ifFalse: [ ^ self ].
	
	self
		assert: [ image form == aForm ]
		description: [ 'Form must belong to current image' ].

	form := aForm.
	bitmap := nil.
	self requestLayout.
	self invalidate
]

{ #category : #accessing }
BlInfiniteExampleGalleryImageElement >> image: aGalleryImage [

	image = aGalleryImage
		ifTrue: [ ^ self ].
	
	form := nil.
	image := aGalleryImage.
	itemElement text: (aGalleryImage id asRopedText
		foreground: Color white;
		fontSize: 14;
		weight: 50;
		fontName: 'Helvetica Neue').
	
	self loadImage
]

{ #category : #initialization }
BlInfiniteExampleGalleryImageElement >> initialize [
	super initialize.

	self background: Color veryVeryDarkGray lighter.
	
	itemElement := BlTextElement new
		geometry: BlEllipse new;
		background: (Color gray alpha: 0.4);
		border: (BlBorder paint: (Color white alpha: 0.2) width: 1);
		effect: (BlBlurBelowEffect radius: 2);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c frame vertical alignCenter.
			c padding: (BlInsets all: 10) ];
		yourself.
	
	self padding: (BlInsets left: 20).
	self addChild: itemElement
]

{ #category : #accessing }
BlInfiniteExampleGalleryImageElement >> loadImage [
	| anImage aForm |
	
	loader ifNotNil: #terminate.
	anImage := image.
	aForm := form.
	
	(anImage form isNotNil and: [ anImage form extent = self extent asIntegerPoint ])
		ifTrue: [
			aForm = anImage form
				ifFalse: [ self form: anImage form ].
			^ self ].

	loader := [
		| aNewForm timesRetry aByteArray |
		timesRetry := 0.
		[ (aByteArray := (image loadUrl: self extent asIntegerPoint) asUrl retrieveContents) isNil and: [ 
			timesRetry < 5 ] ] whileTrue: [ timesRetry := timesRetry + 1 ].
		aByteArray ifNotNil: [
			aNewForm := Form fromBinaryStream: aByteArray readStream.
			anImage form: aNewForm.
			image = anImage
				ifTrue: [
					BlUniverse default animationManager
						addAnimation: (BlTaskAction on: [ self form: aNewForm ]) ] ] ] fork
]

{ #category : #layout }
BlInfiniteExampleGalleryImageElement >> onMeasure: anExtentMeasurementSpec [
	| aWidth aHeight aWidthSpec aHeightSpec |
	super onMeasure: anExtentMeasurementSpec.
	
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	aWidth := aWidthSpec isUnspecified
		ifTrue: [ self defaultWidth ]
		ifFalse: [ aWidthSpec size ].
		"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeight := aHeightSpec isUnspecified
		ifTrue: [ (aWidth / 16 * 9) ]
		ifFalse: [ aHeightSpec size ].

	self measuredExtent: aWidth @ aHeight
]
