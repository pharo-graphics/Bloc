accessing
fileName
	^ fileName ifNil: [ fileName := self askFileName ]