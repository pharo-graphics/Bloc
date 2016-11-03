as yet unclassified
hostSpaceChanged
	self hostSpace ifNil:[^ self].
	self root extent: self extent.
	self beDirtyArea.