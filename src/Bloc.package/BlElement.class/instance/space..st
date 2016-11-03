accessing
space: aSpace
	"Set space to be accessed directly from my multiple methods.
	Update the space reference for my children.
	aSpace must not be nil."
	self assert: aSpace isNotNil.
	space := aSpace.
	self childrenDo: [ :each | each space: aSpace ]