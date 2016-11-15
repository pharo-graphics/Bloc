private
createRemoveCommand: startPosition itemCount: itemCount

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil