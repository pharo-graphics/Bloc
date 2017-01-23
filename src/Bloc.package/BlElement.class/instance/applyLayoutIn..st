layout
applyLayoutIn: aRectangle
	"Layout me and my children within aRectangle in my local coordinates.
	Note: aRectangle may be a temporary or mutable rectangle, so you must not
	store or refer it without making a copy!
	Note: subclasses should not override me, instead override onLayout: for concrete implementation.
	aRectangle must not be nil"
	| oldExtent newExtent newPosition extentChanged |

	oldExtent := self extent.
	newPosition := aRectangle origin.
	newExtent := aRectangle extent.
	extentChanged := newExtent ~= oldExtent.

	"Fast exit if I or any of my children did not request layout update
	and if my current bounds are the same as aRectangle"
	(self isLayoutRequested or: [ extentChanged or: [ newPosition ~= self position ] ])
		ifFalse: [ ^ self ].

	"! actually change my position and extent !"
	self position: newPosition extent: newExtent.

	"if my extent did not change and if I or any of my children did not request layout we do nothing"
	(extentChanged or: [ self isLayoutRequested ])
		ifTrue: [ self onLayout: aRectangle ].
		
	"we are done, mark that there are no layout requests pending"
	self layout requestingLayout: false