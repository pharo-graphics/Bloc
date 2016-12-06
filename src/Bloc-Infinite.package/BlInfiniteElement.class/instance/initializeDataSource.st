initialization
initializeDataSource
	dataSource := self defaultDataSource.
	dataSourceManager := self defaultDataSourceManager.
	self defaultDataSourceController
		element: self;
		dataSourceManager: dataSourceManager