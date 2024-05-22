"
I display a sprite sequencially, to mimic animation.
Each sprite is a square of 32@32px, in a grid of 128@128px.

"
Class {
	#name : #RdvSpriteAnimation,
	#superclass : #Morph,
	#instVars : [
		'sprite',
		'position',
		'topLeft',
		'bottomRight'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #drawing }
RdvSpriteAnimation >> computeNewSpriteBounds [
	"coordinate of next sprite, 32 pixels on the left"

	topLeft := topLeft translateBy: 32 @ 0.
	bottomRight := bottomRight translateBy: 32 @ 0.

	"we move to the next sprite. If we reach the end of one line"
	bottomRight x > 128
		ifTrue: [ bottomRight := 32 @ (bottomRight y + 32).
			topLeft := 0 @ (topLeft y + 32) ].
	"we reach the end of the grid, restart from 0"
	bottomRight y > 128
		ifTrue: [ self initSpritePosition ]
]

{ #category : #drawing }
RdvSpriteAnimation >> drawMagnifiedSpriteOn: aCanvas [

	aCanvas
		paintImage:
			((sprite contentsOfArea:
				  (Rectangle point: topLeft point: bottomRight)) magnifyBy:
				 self magnifyFactor)
		at: self topLeft
]

{ #category : #drawing }
RdvSpriteAnimation >> drawMiniSpriteOn: aCanvas [

	self drawMiniSpriteOn: aCanvas at: (self topRight translateBy: -32 @ 0).
	self drawMiniSpriteOn: aCanvas at:(self rightCenter translateBy: -32 @ -16).
	self drawMiniSpriteOn: aCanvas at: (self bottomRight translateBy: -32 @ -32).
	self drawMiniSpriteOn: aCanvas at: (self bottomCenter translateBy: -16 @ -32).
	self drawMiniSpriteOn: aCanvas at: (self bottomLeft translateBy: 0 @ -32).
	self drawMiniSpriteOn: aCanvas at: (self leftCenter translateBy: 0 @ -16).
	self drawMiniSpriteOn: aCanvas at: self topLeft.
	self drawMiniSpriteOn: aCanvas at: (self topCenter translateBy: -16 @ 0).
	self drawMiniSpriteOn: aCanvas at: (self center translateBy: -16 @ -16).
	
]

{ #category : #drawing }
RdvSpriteAnimation >> drawMiniSpriteOn: aCanvas at: aPosition [

	aCanvas
		paintImage: sprite
		at: aPosition
		sourceRect: (Rectangle point: topLeft point: bottomRight).
]

{ #category : #drawing }
RdvSpriteAnimation >> drawOn: aCanvas [
 	aCanvas fillColor: Color green.
	self drawMagnifiedSpriteOn: aCanvas.
	self drawMiniSpriteOn: aCanvas 
]

{ #category : #initialization }
RdvSpriteAnimation >> initSpritePosition [
	topLeft := 0 @ 0.
	bottomRight := 32 @ 32.
]

{ #category : #initialization }
RdvSpriteAnimation >> initialize [
	super initialize.
	sprite := ZnEasy
		getPng: 'https://opengameart.org/sites/default/files/spritesheet_caveman.png'.

	self initSpritePosition.
	self extent: (32 * self magnifyFactor) @ (32 * self magnifyFactor)
]

{ #category : #initialization }
RdvSpriteAnimation >> magnifyFactor [
	^ 5
]

{ #category : #initialization }
RdvSpriteAnimation >> open [
	<script: 'self new openInWindow'>
]

{ #category : #stepping }
RdvSpriteAnimation >> step [
	self computeNewSpriteBounds.

	self changed.
]

{ #category : #stepping }
RdvSpriteAnimation >> stepTime [
	^ 100
]
