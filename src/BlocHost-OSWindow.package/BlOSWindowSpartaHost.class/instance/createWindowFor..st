as yet unclassified
createWindowFor: aSpace
	| attrs win |
	attrs := self createAttributesFor: aSpace.
	win := BlOSWindow createWithAttributes: attrs.
	win withSpartaRenderer.
	aSpace hostSpace: win