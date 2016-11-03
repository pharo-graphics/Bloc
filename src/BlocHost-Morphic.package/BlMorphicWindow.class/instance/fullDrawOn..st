drawing
fullDrawOn: aCanvas
	self visible
		ifFalse: [ ^ self ].
	(aCanvas isVisible: self fullBounds)
		ifFalse: [ ^ self ].
	"Draw the full Morphic structure on the given Canvas"
	super fullDrawOn: aCanvas.
	(self hasProperty: #errorOnDraw)
		ifTrue: [ ^ self drawErrorOn: aCanvas ].
	[ 
	self renderer lock critical: [ 
		self renderer athensSurface ifNil: [ ^ self ].
		self renderer athensSurface displayOnMorphicCanvas: aCanvas at: self layoutBounds origin.
		self renderNeeded.
		 ] 
	] on: Error
		do: [ :err | 
			self setProperty: #errorOnDraw toValue: true.
			self setProperty: #drawError toValue: err freeze.
			^ self drawErrorOn: aCanvas ].
