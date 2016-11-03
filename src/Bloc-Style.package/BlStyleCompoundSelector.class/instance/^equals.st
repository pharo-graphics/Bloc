testing
= aSelector
	^ aSelector isSimpleSelector not and: [ self selectors = aSelector selectors ]