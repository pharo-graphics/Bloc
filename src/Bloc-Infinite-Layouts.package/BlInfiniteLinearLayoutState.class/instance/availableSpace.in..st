accessing
availableSpace: aNumber in: aLayout

	"uncomment if you get too many re-layouts.
	the actual available space value might slightly exceed maximum space, it is ok"
	"self
		assert: [ aNumber <= aLayout orientation maximumSpace ]
		description: [ 'Available space can not be greater that maximum space' ]."
	
	availableSpace := aNumber