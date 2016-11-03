measure
measure: anElement with: anExtentSpec
	| widthSpec heightSpec hPadding vPadding widthSpecSansPadding heightSpecSansPadding widthSansPadding heightSansPadding measuredWidth measuredHeight |

	horizontalAxis element: anElement.
	horizontalAxis layout: self.
	verticalAxis element: anElement.
	verticalAxis layout: self.
	measurer layout: self.

	widthSpec := anExtentSpec widthSpec.
	heightSpec := anExtentSpec heightSpec.
	
	self invalidateStructure.
	self checkConsistency: anElement.
	self invalidateValues.

	hPadding := anElement insets width.
	vPadding := anElement insets height.
	
	widthSpecSansPadding := self adjust: widthSpec by: hPadding negated.
	heightSpecSansPadding := self adjust: heightSpec by: vPadding negated.
	
	self measurer measureChildren: anElement parentSpec: anExtentSpec isFirstPass: true.
		
	self orientation isHorizontal
		ifTrue: [
			widthSansPadding := horizontalAxis measure: widthSpecSansPadding.
			self measurer
				measureChildren: anElement
				parentSpec: widthSpecSansPadding @ heightSpecSansPadding
				isFirstPass: false.
			heightSansPadding := verticalAxis measure: heightSpecSansPadding ]
		ifFalse: [ 
			heightSansPadding := verticalAxis measure: heightSpecSansPadding.
			self measurer
				measureChildren: anElement
				parentSpec: widthSpecSansPadding @ heightSpecSansPadding
				isFirstPass: false.
			widthSansPadding := horizontalAxis measure: widthSpecSansPadding ].
	
	measuredWidth := (widthSansPadding + hPadding).
	measuredHeight := (heightSansPadding + vPadding).

	anElement measuredExtent: (anExtentSpec sizeFor: measuredWidth @ measuredHeight)