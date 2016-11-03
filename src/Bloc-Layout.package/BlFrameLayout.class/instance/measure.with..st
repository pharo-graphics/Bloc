measure
measure: anElement with: anExtentSpec
	| matchParentChildren |

	"First measure children that know their size (exact and fit content),
	collecting those that needs to be measured later after we know parent's size"
	matchParentChildren := self measureChildren: anElement with: anExtentSpec.
	"Second pass to measure children that match parent"
	self measureMatching: matchParentChildren of: anElement with: anExtentSpec