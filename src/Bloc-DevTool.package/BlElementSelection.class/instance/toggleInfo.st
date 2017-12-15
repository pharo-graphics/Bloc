actions
toggleInfo
	self hasInformation
		ifTrue: [ self hideInfo ]
		ifFalse: [ self showInfo ]