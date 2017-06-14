order
isActionHandled
	| traitMethods |
	traitMethods := (method origin withAllSuperclasses
		collect: [ :aClass | ((aClass traitComposition methodDescriptionsForSelector: method selector) collect: #locatedMethods) ]) flattened.
		
	^ traitMethods isNotEmpty