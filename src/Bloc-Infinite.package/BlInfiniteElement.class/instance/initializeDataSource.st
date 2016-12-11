initialization
initializeDataSource
	dataSource := self defaultDataSource.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	
	dataSourceManager := self defaultDataSourceManager.
	self defaultDataSourceController
		element: self;
		dataSourceManager: dataSourceManager