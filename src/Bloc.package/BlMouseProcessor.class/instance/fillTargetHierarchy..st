event processing
fillTargetHierarchy: aTarget
	^ Array streamContents: [ :aStream |
		aTarget parentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]