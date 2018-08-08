order
isActionHandled	
	^ method methodClass allSuperclasses
		detect: [ :aClass | (aClass compiledMethodAt: method selector ifPresent: [ true ] ifAbsent: [ false]) and: [ (aClass >> method selector) isSubclassResponsibility ] ]
		ifFound: [ true ]
		ifNone: [ false ]