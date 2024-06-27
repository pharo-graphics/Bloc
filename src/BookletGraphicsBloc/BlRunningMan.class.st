"
Sprite animation in bloc, click in the open method to look at it.
"
Class {
	#name : #BlRunningMan,
	#superclass : #BlElement,
	#instVars : [
		'spriteGrid'
	],
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #initialization }
BlRunningMan >> initSpritePosition [

	| sprite |
	sprite := ZnEasy getPng:
		          'https://opengameart.org/sites/default/files/spritesheet_caveman.png'.

	spriteGrid := OrderedCollection new.

	0 to: 3 do: [ :y |
		0 to: 3 do: [ :x |
			spriteGrid add: (BlImageBackground image: ((sprite contentsOfArea:
						   (Rectangle
							    point: (x * 32) @ (y * 32)
							    point: ((x + 1) * 32) @ ((y + 1) * 32))) magnifyBy:
						  self magnifyFactor)) ] ].

	
]

{ #category : #initialization }
BlRunningMan >> initialize [

	super initialize.

	self initSpritePosition.

	self
		size: 32 * self magnifyFactor @ (32 * self magnifyFactor);
		background: (BlPaintBackground paint: (Color green alpha: 0.2));
		border: (BlBorder paint: Color black width: 3);
		addChild: self runningMan
]

{ #category : #initialization }
BlRunningMan >> magnifyFactor [
	^ 10
]

{ #category : #'instance creation' }
BlRunningMan >> open [
	<demo>
	<script: 'self new openInNewSpace'>
]

{ #category : #'execution - private' }
BlRunningMan >> runningMan [

	| animation |
	animation := BlNumberTransition new
		             from: 1;
		             to: spriteGrid size;
		             by: 1;
		             beInfinite;
		             duration: 2 seconds;
		             onStepDo: [ :aValue :anElement |
			             anElement background: (spriteGrid at: aValue) ].

	^ BlElement new
		  size: 32 * self magnifyFactor @ (32 * self magnifyFactor);
		  addAnimation: animation
]
