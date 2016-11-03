*Bloc
fromStream: aStringOrStream 
	| doc |
	doc := XMLDOMParser parse: aStringOrStream.
	^ self new importXMLDocument: doc