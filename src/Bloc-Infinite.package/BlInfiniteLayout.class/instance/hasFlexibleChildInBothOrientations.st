testing
hasFlexibleChildInBothOrientations
	"Return true if there are children with non-exact resizer"
	<return: #Boolean>
	
	self childrenDo: [ :anElement |
		(anElement horizontal resizer isExact or: [ 
			anElement vertical resizer isExact ])
				ifFalse: [ ^ true ] ].
	^ false