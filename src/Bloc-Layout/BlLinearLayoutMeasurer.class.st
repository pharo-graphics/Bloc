Class {
	#name : #BlLinearLayoutMeasurer,
	#superclass : #Object,
	#instVars : [
		'isBaselineAligned',
		'useLargestChild',
		'cellSpacing',
		'nodes',
		'parent',
		'breadthSpec',
		'lengthSpec',
		'orientation',
		'totalLength',
		'totalWeight',
		'skippedMeasure',
		'extentSpec',
		'usedExcessSpace',
		'largestChildLength',
		'matchBreadth'
	],
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #accessing }
BlLinearLayoutMeasurer >> breadthSpec [
	^ breadthSpec
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> cellSpacing [
	^ cellSpacing
]

{ #category : #initialization }
BlLinearLayoutMeasurer >> initialize [
	super initialize.

	useLargestChild := false.
	isBaselineAligned := false.
	cellSpacing := 0.

	totalLength := 0.
	totalWeight := 0.
	usedExcessSpace := 0.
	skippedMeasure := false.
	matchBreadth := false.
	largestChildLength := 0
]

{ #category : #initialization }
BlLinearLayoutMeasurer >> initializeWith: aParentElement extentSpec: anExtentSpec orientation: aBlLinearLayoutOrientation [

	parent := aParentElement.
	orientation := aBlLinearLayoutOrientation.
	
	extentSpec := anExtentSpec.
	breadthSpec := orientation breadthSpec: anExtentSpec.
	lengthSpec := orientation lengthSpec: anExtentSpec.

	nodes := aParentElement children accountedByLayout
		collect: [ :aChildElement | BlLinearLayoutNode new initializeWith: aChildElement orientation: orientation ]
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> isBaselineAligned [
	^ isBaselineAligned
]

{ #category : #testing }
BlLinearLayoutMeasurer >> isBreadthExact [
	^ self breadthSpec isExact
]

{ #category : #testing }
BlLinearLayoutMeasurer >> isLengthExact [
	^ self lengthSpec isExact
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> lengthSpec [
	^ lengthSpec
]

{ #category : #measuring }
BlLinearLayoutMeasurer >> measure [

	"See how wide everyone is. Also remember max height."
	self nodes do: [ :aNode |
		| matchBreadthLocally childBreadth |
	
		aNode hasSpaceBefore
			ifTrue: [ totalLength := totalLength + self cellSpacing ].
		
		totalWeight := totalWeight + aNode weight.
		
		(self isLengthExact and: [ aNode shouldUseExcessSpace ])
			ifTrue: [
				"Optimization: don't bother measuring children who are only laid out using excess space.
				These views will get measured later if we have space to distribute."
				totalLength := self isLengthExact
					ifTrue: [ totalLength + aNode marginLength ]
					ifFalse: [ totalLength max: (totalLength + aNode marginLength) ].
				"Baseline alignment requires to measure widgets to obtain the baseline offset (in particular for TextElements).
				The following defeats the optimization mentioned above.
				Allow the child to use as much space as it wants because we can shrink things later (and re-measure)."
				self isBaselineAligned
					ifTrue: [ aNode measure: BlExtentMeasurementSpec unspecified ]
					ifFalse: [ skippedMeasure := true ] ]
			ifFalse: [
				| usedLength childLength |
				"The widthMode is either UNSPECIFIED or AT_MOST, and
				this child is only laid out using excess space.
				Measure using WRAP_CONTENT so that we can find out the view's optimal width.
				We'll restore the original width of 0 after measurement."
				aNode shouldUseExcessSpace
					ifTrue: [ aNode lengthResizer: BlLayoutResizer fitContent ].

				"Determine how big this child would like to be.
				If this or previous children have given a weight,
				then we allow it to use all available space (and we will shrink things later if needed)."
				usedLength := totalWeight isZero
					ifTrue: [ totalLength ]
					ifFalse: [ 0 ].
				orientation
					measureChildWithMargin: aNode element
					parentSpec: extentSpec
					breadthUsed: 0
					lengthUsed: usedLength.

				childLength := aNode measuredLength.
				aNode shouldUseExcessSpace
					ifTrue: [
						"Restore the original width and record how much space
						we've allocated to excess-only children so that we can
						match the behavior of EXACTLY measurement."
						aNode lengthResizer: BlLayoutResizer matchParent.
						usedExcessSpace := usedExcessSpace + childLength ].
				
				totalLength := self isLengthExact
					ifTrue: [ totalLength + childLength + aNode marginLength ]
					ifFalse: [ totalLength max: (totalLength + childLength + aNode marginLength) ].
				
				self useLargestChild
					ifTrue: [ largestChildLength := largestChildLength max: childLength ] ].
		
		matchBreadthLocally := false.
		(self isBreadthExact not and: [ aNode breadthResizer isMatchParent ])
			ifTrue: [
				"The height of the linear layout will scale, and at least one child said it wanted to match our height.
				Set a flag indicating that we need to remeasure at least that view when we know our height."
				matchBreadth := true.
				matchBreadthLocally := true ].
		
		childBreadth := aNode measuredBreadth + aNode marginBreadth.
		
		(self isBaselineAligned and: [ aNode element supportsBaseline ])
			ifTrue: [
				| childBaseline |
				childBaseline := aNode element baselineOffset.
				
				
			].
		
	]














]

{ #category : #accessing }
BlLinearLayoutMeasurer >> nodes [
	<return: #Collection of: #BlLinearLayoutNode>

	^ nodes
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> parent [
	^ parent
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> useLargestChild [
	^ useLargestChild
]
