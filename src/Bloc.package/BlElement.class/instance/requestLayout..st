layout
requestLayout: anElement
	"Request invalidation of layout on next space pulse originally
	emitted by a given element.
	Note: there should be no ===self isLayoutRequested ifTrue: [ ^ self ]===
	check since there can be a case when I am requesting layout, but my parent
	still does not"

	self layout requestingLayout: true.
	"checking for parent to be not nil is faster when inlined instead
	of using withParent:. It is critical because this method is being
	sent quite often and should be performant"
	self parent
		ifNotNil: [ :aParent | aParent requestLayout: anElement ]
		"There is no parent, probably I am a root element, let's check Space"
		ifNil: [ self space
			"If my parent is nil, but I am added to space, we need to let it know that we requested a layout by asking for a next pulse"
			ifNotNil: [ :aSpace | aSpace requestNextPulse ] ]