accessing
dragView: aDragView
	dragView ifNotNil: [ dragView removeFromParent ].
	dragView := aDragView.
	self space glass addChild: aDragView.