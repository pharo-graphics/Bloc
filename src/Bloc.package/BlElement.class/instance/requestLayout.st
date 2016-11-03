layout
requestLayout
	"Request invalidation of layout on next system step."
	self requestingLayout ifTrue:[^ self].
	self requestingLayout: true.
	"checking for parent to be not nil is faster when inlined instead
	of using ownerDo:. It is critical because this method is being
	sent quite often and should be performant"
	self parent ifNotNil: [ :element| element requestLayout ]