Extension { #name : #BlElement }

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeAsForm [

	| aCanvas |
	self isLayoutRequested
		ifTrue: [ self forceLayout ].

	aCanvas := AeCanvas extent: self extent.
	aCanvas fullDraw: self.
	^ aCanvas asForm

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
	myBackground := self background.
	myBackground isTransparent
		ifTrue: [ aeCanvas setBackgroundOff ]
		ifFalse: [ myBackground aeApplyTo: aeCanvas ].

	self border aeApplyTo: aeCanvas element: self.
	self geometry aeApplyTo: aeCanvas element: self.

	aeCanvas shouldClipAfterDrawingFigure:
		(self hasChildren and: [ self clipChildren ]).

	aeCanvas drawFigure.

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

	self opacity = 1.0
		ifTrue: [ aeCanvas restoreContextAfter: aBlockClosure ]
		ifFalse: [ aeCanvas paintGroupWith: aBlockClosure alpha: self opacity ]

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
