commands recycling
createCommand: type positionStart: positionStart itemCount: itemCount payload: payload
	"Return a data source command with specified parameters.
	As performance optimisation I use commands pool to reduce amount
	of created objects and reduce garbage collector's work.
	I am also used by BlInfiniteDataSourceCommandsReorderer when it merges multiple commands in one"
	<return: #BlInfiniteDataSourceCommand>
	| command |
	
	command := commandsPool acquire.
	command
		ifNil: [ command := BlInfiniteDataSourceCommand new
			type: type;
			positionStart: positionStart;
			itemCount: itemCount;
			payload: payload ]
		ifNotNil: [ 
			command
				type: type;
				positionStart: positionStart;
				itemCount: itemCount;
				payload: payload ].
	^ command