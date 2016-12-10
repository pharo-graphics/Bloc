private - assertions
assertNotInLayoutOrScroll

	"During layout initialization infinite element may still be not set"
	infiniteElement ifNotNil: [ :anElement |
		anElement assertNotInLayoutOrScroll ]