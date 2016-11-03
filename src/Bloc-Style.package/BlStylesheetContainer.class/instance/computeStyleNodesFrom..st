as yet unclassified
computeStyleNodesFrom: aNode
	| aStylesheetList parent |
	aStylesheetList := OrderedCollection new.
	parent := aNode parent.
	[ parent isNotNil ] whileTrue: [ 
		aStylesheetList addAll: parent stylesheets.
		parent := parent parent ].
	^ self computeStyleNodesFrom: aNode stylesheets: aStylesheetList ordinal: 0.