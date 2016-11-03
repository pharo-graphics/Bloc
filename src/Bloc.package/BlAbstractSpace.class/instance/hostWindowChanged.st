change reporting
hostWindowChanged
	self hostWindow ifNil:[^ self].
	self root extent: self contentExtent.
	self beDirtyArea.