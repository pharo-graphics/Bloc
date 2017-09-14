instance creation
convertFromURL: anUrl
	| doc |
	doc := XMLDOMParser parse: anUrl asZnUrl retrieveContents asString.
	^ self new convertXMLDocument: doc