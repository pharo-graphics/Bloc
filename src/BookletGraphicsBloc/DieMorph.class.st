"
(DieMorph faces: 9) openInWorld
"
Class {
	#name : #DieMorph,
	#superclass : #Morph,
	#instVars : [
		'faces',
		'dieValue',
		'isStopped'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #'as yet unclassified' }
DieMorph class >> faces: aNumber [

	^ self new faces: aNumber
]

{ #category : #accessing }
DieMorph >> dieValue: aNumber [

	((aNumber isInteger and: [ aNumber > 0 ]) and: [ aNumber <= faces ]) 
		ifFalse: [ ^ self ].
	dieValue := aNumber.
	self changed
]

{ #category : #drawing }
DieMorph >> drawDotOn: aCanvas at: aPoint [

	aCanvas
		fillOval: (Rectangle
				 center: self position + (self extent * aPoint)
				 extent: self extent / 6)
		color: Color black
]

{ #category : #drawing }
DieMorph >> drawOn: aCanvas [

	| theCanvas |
	theCanvas := aCanvas asAlphaBlendingCanvas: 0.5.
	super drawOn: theCanvas.
	(self perform: ('face' , dieValue asString) asSymbol) do: [ :aPoint | 
		self drawDotOn: theCanvas at: aPoint ]
]

{ #category : #geometry }
DieMorph >> face1 [

	^ { (0.5 @ 0.5) }
]

{ #category : #geometry }
DieMorph >> face2 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.75) }
]

{ #category : #geometry }
DieMorph >> face3 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.75).
		  (0.5 @ 0.5) }
]

{ #category : #geometry }
DieMorph >> face4 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75) }
]

{ #category : #geometry }
DieMorph >> face5 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.5 @ 0.5) }
]

{ #category : #geometry }
DieMorph >> face6 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5) }
]

{ #category : #geometry }
DieMorph >> face7 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5) }
]

{ #category : #geometry }
DieMorph >> face8 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5).
		  (0.5 @ 0.25) }
]

{ #category : #geometry }
DieMorph >> face9 [

	^ { 
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5).
		  (0.5 @ 0.25).
		  (0.5 @ 0.75) }
]

{ #category : #accessing }
DieMorph >> faces: aNumber [

	"Set the number of faces"

	((aNumber isInteger and: [ aNumber > 0 ]) and: [ aNumber <= 9 ]) 
		ifTrue: [ faces := aNumber ]
]

{ #category : #'event handling' }
DieMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #initialization }
DieMorph >> initialize [

	super initialize.
	self extent: 50 @ 50.
	self
		useGradientFill;
		borderWidth: 2;
		useRoundedCorners.
	self setBorderStyle: #complexRaised.
	self fillStyle direction: self extent.
	self color: Color green.
	dieValue := 1.
	faces := 6.
	isStopped := false
]

{ #category : #'event handling' }
DieMorph >> mouseDown: anEvent [

	anEvent redButtonPressed ifTrue: [ isStopped := isStopped not ]
]

{ #category : #'instance creation' }
DieMorph >> open [
	<script: '(self faces: 9) openInWorld'>
]

{ #category : #stepping }
DieMorph >> step [

	isStopped ifFalse: [ self dieValue: (1 to: faces) atRandom ]
]

{ #category : #stepping }
DieMorph >> stepTime [

	^ 1000
]
