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
	
	self children isEmpty ifTrue: [ ^self ].

	aeCanvas prepareToDrawChildrenWithClipping: self clipChildren.
	self children sortedByElevation do: [ :each |
		each aeFullDrawOn: aeCanvas ].
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas [

	self aeDrawOn: aeCanvas with: [

		"My position is applied before my transformation matrix,
		which may have an additional translation."
		aeCanvas pathTranslate: self position.
		self transformation aeApplyTo: aeCanvas.

		self aeDrawOnlyMeOn: aeCanvas.
		self aeDrawChildrenOn: aeCanvas ]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas with: aBlockClosure [

	self opacity = 1.0
		ifTrue: [ aeCanvas restoreContextAfter: aBlockClosure ]
		ifFalse: [ aeCanvas paintGroupWith: aBlockClosure alpha: self opacity ]

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOnlyMeOn: aeCanvas [
	"Draw my geometry with the corresponding background and border.

	Notes:
	- AeCanvas requires background to be set up first (see class comment).
	- Pre-condition: position and transformations are already applied on the canvas.
	- Post-condition: position and transformations are maintanined intact."
	
	| myBackground myBorder |
	myBackground := self background.
	myBackground isTransparent
		ifTrue: [ aeCanvas setBackgroundOff ]
		ifFalse: [ myBackground aeApplyTo: aeCanvas ].

	myBorder := self border.
	myBorder isTransparent
		ifTrue: [ aeCanvas setBorderOff ]
		ifFalse: [
			self outskirts aeApplyTo: aeCanvas.
			aeCanvas setBorderBlock: [
				myBorder paint aeApplyTo: aeCanvas.
				myBorder style aeApplyTo: aeCanvas.
				aeCanvas setBorderWidth: myBorder width ] ].

	self geometry aeApplyTo: aeCanvas element: self.

	aeCanvas drawFigure.

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeFullDrawOn: aCanvas [
	"flags clearNeedsPaint."
	
	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].

	self aeDrawOn: aCanvas
]
