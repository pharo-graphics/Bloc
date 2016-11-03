as yet unclassified
createWindowFor: aSpace
	| attrs win |
	attrs := self createAttributesFor: aSpace.
	win := BlOSWindow createWithAttributes: attrs.
	win withAthensRenderer.
	aSpace hostSpace: win