testing
hasFlexibleChildInBothOrientations
	"Return true if there are children with non-exact resizer"
	<return: #Boolean>
	
	self childrenDo: [ :anElement |
		(anElement constraints horizontal resizer isExact or: [ 
			anElement constraints vertical resizer isExact ])
				ifFalse: [ ^ true ] ].
	^ false