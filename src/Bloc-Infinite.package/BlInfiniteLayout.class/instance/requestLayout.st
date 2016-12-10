layout
requestLayout
	"During layout initialization infinite element may still be not set"
	infiniteElement
		ifNotNil: [ :anElement | anElement requestLayout ]