private flags testing
isUpdated
	^ flags at: #update ifAbsent: [ false ]