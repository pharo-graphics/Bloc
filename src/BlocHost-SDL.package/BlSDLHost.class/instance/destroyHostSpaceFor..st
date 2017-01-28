host - api
destroyHostSpaceFor: aSpace
	| aWindowID |

	self
		assert: [ aSpace hasHost ]
		description: [ 'Space must have a host!' ].
	
	aWindowID := aSpace hostSpace windowID.
	aSpace hostSpace close.
	self unregisterHostSpace: aWindowID.
	aSpace hostSpace: nil