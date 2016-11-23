private - flags testing
wasReturnedFromScrap
	<return: #Boolean>

	^ 	flags at: #returnedFromScrap ifAbsent: [ false ]