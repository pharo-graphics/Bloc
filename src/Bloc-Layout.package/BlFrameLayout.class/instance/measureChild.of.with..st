measure
measureChild: aChildElement of: anElement with: anExtentSpec
	| aParentHeight aParentWidth |

	aParentWidth := anExtentSpec widthSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ anExtentSpec widthSpec size ].
	aParentHeight := anExtentSpec heightSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ anExtentSpec heightSpec size ].

	self
		measureChild: aChildElement
		of: anElement
		with: anExtentSpec
		width: aParentWidth
		height: aParentHeight