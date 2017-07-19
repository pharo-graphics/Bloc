accessing
dataSource: aDataSource
	dataSource
		ifNotNil: [ dataSource removeEventHandler: dataSourceObserver ].
	
	dataSource := aDataSource.
	dataSource addEventHandler: dataSourceObserver