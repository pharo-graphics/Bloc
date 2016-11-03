accessing
dragView: aDragView
	dragView ifNotNil:[dragView delete].
	dragView := aDragView.
	self space glass addChild: aDragView.