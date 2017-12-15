converting
inset: aRectangle
	"Answer a rectangle whose size has been reduced by the receiver."
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"
	<return: #Rectangle>

	self isEmpty
		ifTrue: [ ^ aRectangle ].
	^ (aRectangle left + self left) @ (aRectangle top + self top)
		corner: (aRectangle right - self right) @ (aRectangle bottom - self bottom)