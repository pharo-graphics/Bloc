instance creation
convertFromFile: aFileName
	| doc |
	doc := XMLDOMParser parseFileNamed: aFileName.
	^ self new convertXMLDocument: doc