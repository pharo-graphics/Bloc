accessing
traits
	^ (method origin withAllSuperclasses
		collect: [ :aClass | ((aClass traitComposition methodDescriptionsForSelector: method selector) collect: #locatedMethods) ]) flattened