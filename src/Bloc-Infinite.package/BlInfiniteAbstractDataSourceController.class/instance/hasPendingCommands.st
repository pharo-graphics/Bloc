element -> manager
hasPendingCommands
	"Return true if there are pending commands waiting to be processed
	in data source manager, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility