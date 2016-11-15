private
createAddCommand: startPosition itemCount: itemCount

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil