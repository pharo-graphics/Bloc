converting
expand: aRectangle
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"
	self isEmpty
		ifTrue: [ ^ aRectangle ].
	^ (aRectangle left - self left)@(aRectangle top - self top)
		corner: (aRectangle right + self right)@(aRectangle bottom + self bottom)