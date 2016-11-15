private
createUpdateCommand: startPosition itemCount: itemCount payload: anObject

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: startPosition
		itemCount: itemCount
		payload: anObject