layout
requestLayout
	"Request invalidation of layout on next space pulse.
	Note: there should be no ===self isLayoutRequested ifTrue: [ ^ self ]===
	check since there can be a case when I am requesting layout, but my parent
	still does not"

	self layout requestingLayout: true.
	"checking for parent to be not nil is faster when inlined instead
	of using withParent:. It is critical because this method is being
	sent quite often and should be performant"
	self parent
		ifNotNil: [ :aParent | aParent requestLayout ]
		"There is no parent, probably I am a root element, let's check Space"
		ifNil: [ self space
			"If my parent is nil, but I am added to space, we need to request next pulse"
			ifNotNil: [ :aSpace | aSpace requestNextPulse ] ]