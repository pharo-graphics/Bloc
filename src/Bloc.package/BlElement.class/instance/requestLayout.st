layout
requestLayout
	"Request invalidation of layout on next system step.
	Note: there should be no ===self requestingLayout ifTrue: [ ^ self]===
	check since there can be a case when I am requesting layout, but my parent
	still does not"

	self requestingLayout: true.
	"checking for parent to be not nil is faster when inlined instead
	of using ownerDo:. It is critical because this method is being
	sent quite often and should be performant"
	self parent ifNotNil: [ :aParent | aParent requestLayout ]