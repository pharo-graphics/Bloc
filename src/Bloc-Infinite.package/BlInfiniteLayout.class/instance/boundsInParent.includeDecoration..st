children - geometry
boundsInParent: anElement includeDecoration: shouldIncludeDecoration
	"Calculate the bounding box of the Element while taking into account its matrix changes
	(translation, scale etc) with respect to the InfiniteElement.
	If shouldIncludeDecoration is true, they are applied first before applying
	the Elements's matrix so that the decor offsets also go through the same transformation"
	<return: #Rectangle>
	| aLocalBounds |
	
	aLocalBounds := shouldIncludeDecoration
		ifTrue: [ anElement constraints infinite decorationInsets expand: anElement boundsInLocal ]
		ifFalse: [ anElement boundsInLocal ].
	
	^ anElement localBoundsToParent: aLocalBounds