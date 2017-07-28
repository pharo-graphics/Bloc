accessing
dataSource: aDataSource
	dataSource
		ifNotNil: [
			dataSource removeEventHandler: dataSourceObserver.
			dataSource onDetached: self ].
	
	dataSource := aDataSource.
	dataSource addEventHandler: dataSourceObserver.
	dataSource onAttached: self