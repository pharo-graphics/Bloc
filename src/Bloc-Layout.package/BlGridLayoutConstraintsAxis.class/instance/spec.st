private
spec
	"Return child's axis specification.
	spec can not be nil"
	<return: #BlGridLayoutSpec>
	self assert: spec isNotNil.

	^ spec