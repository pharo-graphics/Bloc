accessing
dataSourceManager
	"Return data source manager used in communication with infinite element.
	dataSourceManager can not be nil"
	<return: #BlInfiniteDataSourceManager>
	self assert: dataSourceManager isNotNil.
	
	^ dataSourceManager