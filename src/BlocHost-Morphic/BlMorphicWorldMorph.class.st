Class {
	#name : #BlMorphicWorldMorph,
	#superclass : #WorldMorph,
	#instVars : [
		'display',
		'drawingCache',
		'mySession'
	],
	#category : #'BlocHost-Morphic-World'
}

{ #category : #accessing }
BlMorphicWorldMorph class >> worldState: aWorldState [
	^ self basicNew initializeWith: aWorldState
]

{ #category : #actions }
BlMorphicWorldMorph >> beMain [
	InputEventFetcher deinstall.
	
	Cursor currentCursor: Cursor normal.
	World := self.
	ActiveWorld := self.
	ActiveHand := self hands first.
	Display := display.

	worldState element isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	worldState element space host class uiProcessDo: [ :aProcess |		
		(UIManager default uiProcess ~~ aProcess)
			ifTrue: [ UIManager default uiProcess ifNotNil: #terminate ].

		MorphicUIManager classVarNamed: #UIProcess put: aProcess ]
]

{ #category : #accessing }
BlMorphicWorldMorph >> display [
	<return: #Form>

	^ display
]

{ #category : #initialization }
BlMorphicWorldMorph >> displayExtent [
	^ display extent
]

{ #category : #initialization }
BlMorphicWorldMorph >> displayExtent: aPoint [
	display
		setExtent: aPoint
		depth: display depth.
		
	self changed
]

{ #category : #drawing }
BlMorphicWorldMorph >> drawOnSpartaCanvas: aCanvas [	
	self validateDrawingCache.
	
	aCanvas fill
		paint: self color;
		path: self bounds;
		draw.

	submorphs reverseDo: [ :eachMorph |
		| aBitmap |
		aBitmap := self drawingCache
			at: eachMorph
			ifAbsentPut: [ aCanvas bitmap fromForm: eachMorph imageForm ].
		
		aCanvas fill
			paint: aBitmap;
			path: eachMorph bounds;
			antialiasNone;
			draw ].

	self worldState hands reverseDo: [ :eachHand |
		eachHand submorphs reverseDo: [ :eachMorph |
			| aBitmap |
			aBitmap := self drawingCache
				at: eachMorph
				ifAbsentPut: [ aCanvas bitmap fromForm: eachMorph imageForm ].
			
			aCanvas fill
				paint: aBitmap;
				path: eachMorph bounds;
				antialiasNone;
				draw ] ]
]

{ #category : #accessing }
BlMorphicWorldMorph >> drawingCache [
	^ drawingCache ifNil: [ drawingCache := IdentityDictionary new ]
]

{ #category : #initialization }
BlMorphicWorldMorph >> initializeMenubar [
	| oldWorld oldActiveWorld |

	oldWorld := World.
	oldActiveWorld := ActiveWorld.
	World := self.
	ActiveWorld := self.

	 [ MenubarMorph new
		menuBarItems: worldState menuBuilder menuSpec items;
		open ]
			ensure: [
				World := oldWorld.
				ActiveWorld := oldActiveWorld ]
]

{ #category : #initialization }
BlMorphicWorldMorph >> initializeWith: aWorldState [
	| aHand |
	self initialize.

	display := BlMorphicWorldDisplayScreen extent: 640 @ 480 depth: 32.
	drawingCache := IdentityDictionary new.

	self color: (Color r: 0.94 g: 0.94 b: 0.94 alpha: 1.0).
	self extent: 640@480.

	worldState := aWorldState.
	worldState display: display.

	self addHand: (aHand := HandMorph new).
	aHand instVarNamed: #targetOffset put: 0@0.

	self createTaskbarIfNecessary.
	
	(self theme desktopImageFor: self) ifNotNil: [:aForm |
		self backgroundImage: aForm layout: self theme desktopImageLayout ].
	
	self initializeMenubar
]

{ #category : #'change reporting' }
BlMorphicWorldMorph >> invalidRect: damageRect from: aMorph [
	| myChild |
	super invalidRect: damageRect from: aMorph.
	
	aMorph == self
		ifTrue: [ ^ self ].
		
	myChild := aMorph.
	
	[ myChild isNotNil and: [ myChild owner ~~ self ] ]
		whileTrue: [ myChild := myChild owner ].

	myChild owner == self
		ifTrue: [ self drawingCache removeKey: myChild ifAbsent: [ ] ]
]

{ #category : #recategorized }
BlMorphicWorldMorph >> layoutChanged [
	super layoutChanged.
	
	(worldState isKindOf: BlMorphicWorldState)
		ifTrue: [ worldState element requestLayout ]
]

{ #category : #drawing }
BlMorphicWorldMorph >> validateDrawingCache [
	mySession == Smalltalk session 
		ifFalse: [
			mySession := Smalltalk session.
			self drawingCache removeAll ].

	self drawingCache keys
		do: [ :eachMorph |
			(eachMorph owner == self)
				ifFalse: [ self drawingCache removeKey: eachMorph ifAbsent: [  ] ] ]
]
