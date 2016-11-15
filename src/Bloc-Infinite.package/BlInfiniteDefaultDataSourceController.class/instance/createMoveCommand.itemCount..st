private
createMoveCommand: fromPosition itemCount: toPosition

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: fromPosition
		itemCount: toPosition
		payload: nil