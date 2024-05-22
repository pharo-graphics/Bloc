"
I show a F and a E letter, and an inverse F letter, all defined in a Form.
Each letter has a size of 4@6 pixel, magnified by 25, so 100@150 pixels.
The Form itself has been defined with only 1 color depth, to ease its understanding.

Every 500ms, the canvas is redisplayed, and a new section of the Form is displayed.

"
Class {
	#name : #RdvMorph,
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
RdvMorph >> computeNewSpriteBounds [
	| topLeftX topLeftY bottomRightX bottomRightY |
	topLeftX := topLeft x + 32.
	topLeftY := topLeft y.
	bottomRightX := bottomRight x + 32.
	bottomRightY := bottomRight y.

	"we move to the next sprite. If we reach the end of one line"
	bottomRightX > 128
		ifTrue: [ bottomRightX := 32.
			topLeftX := 0.
			bottomRightY := bottomRightY + 32.
			topLeftY := topLeftY + 32 ].
	"we reach the end of the grid, restart from 0"
	bottomRightY > 128
		ifTrue: [ topLeftX := 0.
			topLeftY := 0.
			bottomRightX := 32.
			bottomRightY := 32 ].
	bottomRight := bottomRightX @ bottomRightY.
	topLeft := topLeftX @ topLeftY
]

{ #category : #drawing }
RdvMorph >> drawOn: aCanvas [
 	aCanvas fillColor: Color green.
	aCanvas
		paintImage: ((sprite contentsOfArea: (Rectangle point: topLeft point: bottomRight)) magnifyBy: self magnifyFactor )
		at: self topLeft
]

{ #category : #initialization }
RdvMorph >> initialize [
	super initialize.
	sprite := ZnEasy
		getPng: 'https://opengameart.org/sites/default/files/spritesheet_caveman.png'.
	topLeft := 0 @ 0.
	bottomRight := 32 @ 32.
	self beTransparent.
	self extent: (32 * self magnifyFactor) @ (32 * self magnifyFactor)
]

{ #category : #initialization }
RdvMorph >> magnifyFactor [
	^ 5
]

{ #category : #initialization }
RdvMorph >> open [
	<script: 'self new openInWindow'>
]

{ #category : #stepping }
RdvMorph >> step [
	self computeNewSpriteBounds.

	self changed.
]

{ #category : #stepping }
RdvMorph >> stepTime [
	^ 500
]
