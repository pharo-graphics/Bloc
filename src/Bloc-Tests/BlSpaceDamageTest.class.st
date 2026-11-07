Class {
	#name : #BlSpaceDamageTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'moved',
		'under',
		'far'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #private }
BlSpaceDamageTest >> drawIn: aRectangle [
	"The pixels of the space in the rectangle, drawn as a host draws a damaged rectangle: only the elements which are in it"

	| canvas |
	canvas := AeCanvas extent: aRectangle extent.
	canvas privateAeCairoSurface deviceOffset: aRectangle origin negated.
	canvas clippingRectangle: aRectangle.
	canvas restoreContextAfter: [ space aeFullDrawOn: canvas ].
	^ canvas asForm
]

{ #category : #private }
BlSpaceDamageTest >> moveTheElement [
	"Draws the space, as the previous frame did, then moves the element and lays the space out without drawing it, as a frame does before drawing the damaged rectangle. A space remembers where each element was drawn: a headless space draws nothing by itself"

	self drawIn: (0 @ 0 extent: space extent).
	space clearDirtyElements.
	moved position: 100 @ 100.
	space doLayout
]

{ #category : #running }
BlSpaceDamageTest >> setUp [
	"An element above another one, and a third one far from them, in a parent which does not clip them"

	| parent |
	super setUp.
	under := BlElement new
		         background: Color green;
		         extent: 40 @ 40;
		         yourself.
	moved := BlElement new
		         background: Color red;
		         extent: 20 @ 20;
		         position: 10 @ 10;
		         yourself.
	far := BlElement new
		       background: Color blue;
		       extent: 20 @ 20;
		       position: 300 @ 200;
		       yourself.
	parent := BlElement new
		          clipChildren: false;
		          extent: 400 @ 300;
		          addChildren: {
				          under.
				          moved.
				          far };
		          yourself.
	space := BlSpace new
		         host: BlHeadlessHost default;
		         extent: 400 @ 300;
		         yourself.
	space root background: Color white.
	space root addChild: parent.
	space
		show;
		settle
]

{ #category : #running }
BlSpaceDamageTest >> tearDown [

	space ifNotNil: [
			space
				close;
				settle ].
	super tearDown
]

{ #category : #tests }
BlSpaceDamageTest >> testDrawingTheDamageOfAMoveDrawsTheSameAsDrawingEverything [
	"The element which was under the moved one is drawn again where the moved one was"

	| screen damage patch expected |
	screen := self drawIn: (0 @ 0 extent: space extent).
	self moveTheElement.
	damage := (space damagedRectangle asRectangle intersect: (0 @ 0 extent: space extent)) rounded.
	patch := self drawIn: damage.
	screen
		copy: damage
		from: 0 @ 0
		in: patch
		rule: Form over.
	expected := self drawIn: (0 @ 0 extent: space extent).
	self assert: screen bits equals: expected bits
]

{ #category : #tests }
BlSpaceDamageTest >> testMovingAnElementDamagesItsOldAndNewPlaceOnly [
	"The damaged rectangle is the one a host draws again: when it is the whole parent, moving an element among thousands draws all of them again"

	| damage |
	self moveTheElement.
	damage := space damagedRectangle.
	self assert: (damage containsRect: (10 @ 10 extent: 20 @ 20)).
	self assert: (damage containsRect: (100 @ 100 extent: 20 @ 20)).
	self deny: (damage intersects: (300 @ 200 extent: 20 @ 20))
]
