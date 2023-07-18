Extension { #name : #BlElement }

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeAsForm [

	| invalidationBounds |
	self isLayoutRequested ifTrue: [ self forceLayout ].

	"We want to consider our border, effect, as well as children's."
	invalidationBounds := self invalidationBounds: BlBounds new.

	^ (AeCanvas extent: invalidationBounds extent)
			pathTranslate: invalidationBounds origin negated;
			fullDraw: self;
			asForm
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawChildrenOn: aeCanvas [
	"Draw my children.
	
	Notes:
	- Receiver assumes that position and transformations are already applied on the canvas."
	
	self children sortedByElevation do: [ :each |
		each aeFullDrawOn: aeCanvas ].
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawEffectAboveGeometryOn: aeCanvas [

	self effect aeDrawAbove: self on: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawEffectBelowGeometryOn: aeCanvas [

	self effect aeDrawBelow: self on: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawGeometryOn: aeCanvas [
	"Draw my geometry with the corresponding background and border.

	Notes:
	- AeCanvas requires background to be set up first (see class comment).
	- Pre-condition: position and transformations are already applied on the canvas.
	- Post-condition: position and transformations are maintanined intact."
	
	| myBackground |
	self geometry aeApplyTo: aeCanvas element: self.

	myBackground := self background.
	myBackground isTransparent
		ifTrue: [ aeCanvas setBackgroundOff ]
		ifFalse: [ myBackground aeApplyTo: aeCanvas ].

	"Border may set stroke options, outskirts and geometry's border path"
	self border aeApplyTo: aeCanvas element: self.

	aeCanvas drawFigureAndPrepareToClip: (self hasChildren and: [ self clipChildren ]).

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas [

	self aeDrawOn: aeCanvas with: [

		"My position is applied before my transformation matrix,
		which may have an additional translation."
		aeCanvas pathTranslate: self position.
		self transformation aeApplyTo: aeCanvas.

		self aeDrawEffectBelowGeometryOn: aeCanvas.
		self aeDrawGeometryOn: aeCanvas.
		self aeDrawEffectAboveGeometryOn: aeCanvas.

		self aeDrawChildrenOn: aeCanvas.
		
		]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas with: aBlockClosure [
	"Evaluate a block closure taking account my opacity.
	The element opacity affects border and background, effects, and 
	recursively to children elements.
	When I have opaque opacity (1.0) I take the fastest branch, restoring
	the Cairo caontext afterwards."

	self opacity < 1.0
		ifTrue: [ aeCanvas paintGroupWith: aBlockClosure alpha: self opacity ]
		ifFalse: [ aeCanvas restoreContextAfter: aBlockClosure ]

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeFullDrawOn: aCanvas [
	"Main entry point to draw myself and my children on an Alexandrie canvas."

	self flag: #todo. "Why is this commented?"
	"flags clearNeedsPaint."
	
	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].

	self aeDrawOn: aCanvas
]
