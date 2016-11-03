layout
applyLayoutIn: aBounds
	"Layout me and my children in aBounds. aBounds are used as my new actual bounds.
	Subclasses should not override me, instead override onLayout:
	for concrete implementation.
	aBounds must not be nil"

	| oldExtent|
	self assert: aBounds isNotNil.
	"Fast exit if I or any of my children did not request layout update
	and if my current bounds are the same as aBounds"
	(self requestingLayout not and: [ aBounds = self boundsInParent ])
		ifTrue: [ ^ self ].
	oldExtent := self extent.
	"! actually change my position and extent !"
	self relocate: aBounds origin.
	self resize: aBounds extent.
	"if my extent did not change and I and any of my children
	did not request layout update there no need to layout them"
	((oldExtent = self extent) not or: [ self requestingLayout ])
		ifTrue: [ self onLayout: aBounds ].
	self requestingLayout: false.