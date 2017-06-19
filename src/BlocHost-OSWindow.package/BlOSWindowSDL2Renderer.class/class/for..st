instance creation
for: aWindowHandle
	^ self basicNew
		initialize;
		initializeWindowHandle: aWindowHandle;
		yourself