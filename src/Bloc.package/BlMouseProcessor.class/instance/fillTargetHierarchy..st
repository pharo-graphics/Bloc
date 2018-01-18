event processing
fillTargetHierarchy: aTarget
	^ Array streamContents: [ :aStream |
		aStream nextPut: aTarget.
		aTarget parentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]