renderer - rendering
doRender: aSpace
	| theDirtyAreas |
	
	self
		assert: [ session == Smalltalk session ]
		description: [ 'Session has been changed! Fix your #prepareToRender: !' ].
	
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Sparta Canvas must be valid at this point!' ].
	
	"collect the dirty area to be updated"
	theDirtyAreas := aSpace dirtyAreas 
		collect: [ :each | each intersect: (0@0 extent: windowExtent) ifNone: [ nil ] ]
		thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	theDirtyAreas do: [ :aBlBounds | 
		spartaCanvas clip by: aBlBounds during: [ 
			aSpace fullDrawOn: spartaCanvas
		].
	].
	spartaCanvas flush.

	self presentAreas: theDirtyAreas