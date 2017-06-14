*BlocHost-OSWindow
isRunning
	"Return true if oswindow driver exists, false otherwise"
	<return: #Boolean>

	^ Current isNotNil and: [ Session == Smalltalk session ]