testing - commands
hasOnlyUpdateCommand
	"Return true if there are only update commands in the queue, false otherwise"
	<return: #Boolean>

	^ self hasUpdateCommand and: [
		(self hasAddCommand or: [
			self hasRemoveCommand or: [ 
				self hasMoveCommand ] ]) not ]