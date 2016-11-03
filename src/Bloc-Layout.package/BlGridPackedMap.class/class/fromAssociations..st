instance creation
fromAssociations: anArrayOfAssociations
	^ self new values: (anArrayOfAssociations collect: #value) keys: (anArrayOfAssociations collect: #key)