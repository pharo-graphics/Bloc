instance creation
convertFromString: aString
	| doc |
	doc := XMLDOMParser parse: aString.
	^ self new convertXMLDocument: doc