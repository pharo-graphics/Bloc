rendering
render: anInstallablePresentation
	^ anInstallablePresentation isAvailable
		ifTrue: [ self morphFrom: anInstallablePresentation ]
		ifFalse: [ self unavailableFrom: anInstallablePresentation ]