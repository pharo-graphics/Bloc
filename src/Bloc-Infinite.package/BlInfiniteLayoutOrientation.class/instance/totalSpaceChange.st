geometry
totalSpaceChange
	"Return the layout space change between the previous layout pass and current layout pass"
	<return: #Number>
	
	^ lastTotalSpace
		ifNil: [ 0 ]
		ifNotNil: [ :aNumber | self totalSpace - aNumber ]