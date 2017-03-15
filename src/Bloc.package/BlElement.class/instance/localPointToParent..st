geometry position convertion
localPointToParent: aPoint
	"Transforma a given point from my local coordinates to local coordinates of my parent.
	Since this transfortmation does not actually involve my parent, it can be performed
	regardless of if I have one"
	<return: #Point>
	| pt |
	"first we should apply my transformation, since it is the only factor
	effecting local nature of a coordinate"
	pt := self transform transformPoint: aPoint.
	"next we should translate it to be within my parent's local coordinates"
	^ pt translateBy: self position