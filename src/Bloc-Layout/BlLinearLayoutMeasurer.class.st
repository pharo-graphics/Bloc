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
		'matchBreadth',
		'maxBreadth',
		'allFillParent',
		'weightedMaxBreadth',
		'alternativeMaxBreadth',
		'measuredLength',
		'layout',
		'interSpacing'
	],
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #measurement }
BlLinearLayoutMeasurer >> baselineMeasure [
	self subclassResponsibility
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> breadthSpec [
	^ breadthSpec
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ self isLengthExact and: [ self shouldUseExcessSpaceForNode: aNode ]
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> cellSpacing [
	^ cellSpacing
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> childBreadthSpecForNode: aNode [

	^ parent layout
		  measurementSpecFor: breadthSpec
		  usedSize:
		  (orientation paddingBreadth: parent) + aNode marginBreadth
		  resizer: aNode breadthResizer
]

{ #category : #initialization }
BlLinearLayoutMeasurer >> initialize [
	super initialize.

	useLargestChild := false.
	isBaselineAligned := false.
	cellSpacing := 0.0.
	interSpacing := 0.0.

	totalLength := 0.0.
	totalWeight := 0.0.
	usedExcessSpace := 0.0.
	skippedMeasure := false.
	matchBreadth := false.
	largestChildLength := 0.0.
	measuredLength := 0.0.
	alternativeMaxBreadth := 0.0.
	maxBreadth := 0.0.
	allFillParent := true.
	weightedMaxBreadth := 0.0
]

{ #category : #initialization }
BlLinearLayoutMeasurer >> initializeWith: aParentElement layout: aLinearLayout extentSpec: anExtentSpec orientation: aBlLinearLayoutOrientation [

	parent := aParentElement.
	orientation := aBlLinearLayoutOrientation.
	layout := aLinearLayout.
	useLargestChild := layout shouldUseLargestChild.
	cellSpacing := layout cellSpacing.
	interSpacing := layout interspace.

	extentSpec := anExtentSpec.
	breadthSpec := orientation breadthSpec: anExtentSpec.
	lengthSpec := orientation lengthSpec: anExtentSpec.

	nodes := aParentElement children accountedByLayout
		collect: [ :aChildElement | BlLinearLayoutNode new initializeWith: aChildElement orientation: orientation ]
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> interspace [

	^ interSpacing
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

{ #category : #measurement }
BlLinearLayoutMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all weighted children to have the minimum size of the largest child"
	
	self useLargestChild
		ifFalse: [ ^ self ].
	
	(lengthSpec isAtMost or: [ lengthSpec isUnspecified ])
		ifFalse: [ ^ self ].
	
	totalLength := 0.
	
	self nodes do: [ :aNode | self updateTotalLengthFromLargestChild: aNode ]
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> lengthSpec [
	^ lengthSpec
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> limitedMeasure [
	| excessSpace remainingExcess remainingNodesCount theLimitedNodes totalLimitedLength maxEachLimitedLength theNodesToShrink totalShrinkedLength |
	
	"Either expand children with weight to take up available space or shrink them if they extend beyond our current bounds.
	If we skipped measurement on any children, we need to measure them now."
	excessSpace := measuredLength - totalLength + usedExcessSpace.
	excessSpace >= 0
		ifTrue: [ ^ self ].

	excessSpace := excessSpace abs.
	remainingExcess := excessSpace.
	
	"we should reduce the size of the fit content limited children"
	theLimitedNodes := self nodes select: [ :eachNode | eachNode lengthResizer isFitContentLimited ].
	theLimitedNodes
		ifEmpty: [ ^ self ].
	
	totalLimitedLength := (theLimitedNodes inject: 0.0 into: [ :aSum :eachNode | aSum + eachNode measuredLength + eachNode marginLength ]) - remainingExcess.
	totalLimitedLength < 0
		ifTrue: [ ^ self ].
	
	maxEachLimitedLength := totalLimitedLength / theLimitedNodes size.
	
	"let's select those nodes that are larger than the max length and need to be schinked"
	theNodesToShrink := theLimitedNodes select: [ :eachNode | eachNode measuredLength > maxEachLimitedLength ].
	theNodesToShrink
		ifEmpty: [ ^ self ].
	
	totalShrinkedLength := (theNodesToShrink inject: 0.0 into: [ :aSum :eachNode | aSum + eachNode measuredLength + eachNode marginLength ]) - remainingExcess.
	totalShrinkedLength < 0
		ifTrue: [ ^ self ].
	
	remainingNodesCount := theNodesToShrink size.
	theNodesToShrink do: [ :eachNode |
			| shareLength childLength childLengthSpec childBreadthSpec |
			
			shareLength := remainingExcess / remainingNodesCount.
			remainingExcess := remainingExcess - shareLength.
			remainingNodesCount := remainingNodesCount - 1.
			
			childLength := eachNode measuredLength - shareLength.
				
			childLengthSpec := BlMeasurementSpec exact: (0.0 max: childLength).
			childBreadthSpec := self childBreadthSpecForNode: eachNode.
				
			 eachNode measure: (orientation extentSpecBreadth: childBreadthSpec lengthSpec: childLengthSpec) ].
		
	measuredLength := measuredLength - excessSpace.
	totalLength := totalLength - excessSpace.
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> measureExactUsingExcessSpace: aNode [
	"Optimization: don't bother measuring children who are only laid out using excess space.
	These views will get measured later if we have space to distribute."
	
	self subclassResponsibility
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> measureOn: anElement [

	anElement ignoreRequestLayoutDuring: [ self preMeasure ].

	self baselineMeasure.
	self largestMeasure.

	totalLength := totalLength + (orientation paddingLength: parent).
	
	"Check against our minimum length"
	measuredLength := totalLength max: (orientation minimalLength: parent).

	"Reconcile our calculated size with the lengthSpec"
	measuredLength := lengthSpec sizeFor: measuredLength.
	
	self limitedMeasure.
	self weightedMeasure.
	self postMeasure.
	self uniformMeasure
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> nodes [
	<return: #Collection of: #BlLinearLayoutNode>

	^ nodes
]

{ #category : #accessing }
BlLinearLayoutMeasurer >> parent [
	<return: #BlElement>

	^ parent
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> postMeasure [

	(allFillParent not and: [ breadthSpec isExact not ])
		ifTrue: [ maxBreadth := alternativeMaxBreadth ].

	maxBreadth := maxBreadth + (orientation paddingBreadth: parent).

	"Check against our minimum height"
	maxBreadth := maxBreadth max: (orientation minimalBreadth: parent).

	parent measuredExtent: (orientation extentBreadth: (breadthSpec sizeFor: maxBreadth) lengthSpec: measuredLength).
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> preMeasure [

	"See how wide/tall everyone is. Also remember max breadth."
	self nodes size > 1 ifTrue: [ 
		totalLength := totalLength + ((self nodes size - 1) * self interspace) ].
	
	self nodes do: [ :aNode |
		| matchBreadthLocally childBreadth shouldUseExcessSpace |
	
		aNode hasSpaceBefore
			ifTrue: [ totalLength := totalLength + self cellSpacing ].
			
		totalWeight := totalWeight + aNode weight.
		
		"we must store the result because it may temporary change during measurement"
		shouldUseExcessSpace := self shouldUseExcessSpaceForNode: aNode.

		(self canMeasureExactUsingExcessSpaceForNode: aNode)
			ifTrue: [ self measureExactUsingExcessSpace: aNode ]
			ifFalse: [
				| usedLength childLength |
				"The lengthMode is either UNSPECIFIED or AT_MOST, and
				this child is only laid out using excess space.
				Measure using FIT_CONTENT so that we can find out the view's optimal length.
				We'll restore the original length of 0 after measurement."
				shouldUseExcessSpace
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
				shouldUseExcessSpace
					ifTrue: [
						"Restore the original width and record how much space
						we've allocated to excess-only children so that we can
						match the behavior of EXACTLY measurement."
						aNode lengthResizer: BlLayoutResizer matchParent.
						usedExcessSpace := usedExcessSpace + childLength ].
				
				self updateTotalLengthAfterMeasuring: aNode.
				
				largestChildLength := largestChildLength max: childLength ].
		
		self flag: 'Add baseline support here'.
		
		matchBreadthLocally := false.
		(self isBreadthExact not and: [ aNode breadthResizer isMatchParent ])
			ifTrue: [
				"The height of the linear layout will scale, and at least one child said it wanted to match our height.
				Set a flag indicating that we need to remeasure at least that view when we know our height."
				matchBreadth := true.
				matchBreadthLocally := true ].
		
		childBreadth := aNode measuredBreadth + aNode marginBreadth.
		self processBaseline: aNode breadth: childBreadth.

		maxBreadth := maxBreadth max: childBreadth.
		allFillParent := allFillParent and: [ aNode breadthResizer isMatchParent ].
		
		aNode weight > 0
			ifTrue: [
				"Heights of weighted elements are bogus if we end up remeasuring, so keep them separate."
				weightedMaxBreadth := (matchBreadthLocally
					ifTrue: [ aNode marginBreadth ]
					ifFalse: [ childBreadth ]) max: weightedMaxBreadth ]
			ifFalse: [
				alternativeMaxBreadth := (matchBreadthLocally
					ifTrue: [ aNode marginBreadth ]
					ifFalse: [ childBreadth ]) max: alternativeMaxBreadth ] ].
			
	self nodes ifNotEmpty: [ :theNodes |
		theNodes last hasSpaceAfter
			ifTrue: [ totalLength := totalLength + self cellSpacing ] ]
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> prepareForWeightedMeasure [
	self subclassResponsibility
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> processBaseline: aNode breadth: aChildBreadth [
	"I process baseline of a given child node if it is supported."

	self subclassResponsibility
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> remainingWeightSum [
	<return: #Number>

	^ self weightSum > 0
		ifTrue: [ self weightSum ]
		ifFalse: [ totalWeight ]
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> shouldUseExcessSpaceForNode: aNode [

	^ (lengthSpec isUnspecified not or: [ useLargestChild ]) and: [
		  aNode shouldUseExcessSpace ]
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> uniformMeasure [
	| uniformMeasureSpec |

	matchBreadth
		ifFalse: [ ^ self ].

	"Pretend that the linear layout has an exact size. This is the measured height of ourselves.
	The measured height should be the max height of the children, changed to accommodate the heightMeasureSpec from the parent"
	
	uniformMeasureSpec := BlMeasurementSpec exact: (orientation measuredBreadth: parent).
	
	self nodes
		select: [ :aNode | aNode breadthResizer isMatchParent ]
		thenDo: [ :aNode |
			| oldResizer |
			"Temporarily force children to reuse their old measured width"
			oldResizer := aNode lengthResizer.
			aNode lengthResizer: (BlLayoutResizer exact: aNode measuredLength).
			
			"Remeasure with new dimensions"
			orientation 
				measureChildWithMargin: aNode element
				parentSpec: (orientation 
					extentSpecBreadth: uniformMeasureSpec
					lengthSpec: self lengthSpec)
				breadthUsed: 0
				lengthUsed: 0.
				
			aNode lengthResizer: oldResizer ].
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> updateTotalLengthAfterMeasuring: aNode [
	"I update the total length after measuring a given node based on its measured length and margin"

	self subclassResponsibility
]

{ #category : #'private - measurement' }
BlLinearLayoutMeasurer >> updateTotalLengthFromLargestChild: aNode [
	"I update the total length taking into account the length of the largest child"

	self subclassResponsibility
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> useLargestChild [
	^ useLargestChild
]

{ #category : #'accessing - properties' }
BlLinearLayoutMeasurer >> weightSum [
	^ layout weightSum
]

{ #category : #measurement }
BlLinearLayoutMeasurer >> weightedMeasure [
	"I measure weighted children if there is enough excess space"	
	| remainingExcess |

	"Check against our minimum length"
	measuredLength := totalLength max: (orientation minimalLength: parent).

	"Reconcile our calculated size with the lengthSpec"
	measuredLength := lengthSpec sizeFor: measuredLength.
	
	"Either expand children with weight to take up available space or shrink them if they extend beyond our current bounds.
	If we skipped measurement on any children, we need to measure them now."
	remainingExcess := measuredLength - totalLength + usedExcessSpace.

	(skippedMeasure or: [ remainingExcess > 0 and: [ totalWeight > 0 ] ])
		ifTrue: [
			| remainingWeightSum |
			
			remainingWeightSum := self remainingWeightSum.
			
			self prepareForWeightedMeasure.
			
			self nodes do: [ :aNode |
				| childWeight childLength childBreadth matchBreadthLocally |
				
				childWeight := aNode weight.
				childWeight > 0
					ifTrue: [
						| shareSpace childLengthSpec childBreadthSpec |
						" Deal with precision "
						shareSpace := (remainingWeightSum closeTo: 0)
							ifTrue: [ 0.0 ]
							ifFalse: [ (childWeight * remainingExcess / remainingWeightSum) asFloat ].

						remainingExcess := remainingExcess - shareSpace.
						remainingWeightSum := remainingWeightSum - childWeight.

						childLength := (self useLargestChild and: [ self isLengthExact not ])
							ifTrue: [ largestChildLength ]
							ifFalse: [ aNode lengthResizer isMatchParent
								"This child needs to be laid out from scratch using only its share of excess space."
								ifTrue: [ shareSpace ]
								"This child had some intrinsic width to which we need to add its share of excess space."
								ifFalse: [ aNode measuredLength + shareSpace ] ].
							
						childLengthSpec := BlMeasurementSpec exact: (0.0 max: childLength).
						childBreadthSpec := self childBreadthSpecForNode: aNode.	
						aNode measure: (orientation extentSpecBreadth: childBreadthSpec lengthSpec: childLengthSpec) ].
				
				self updateTotalLengthAfterMeasuring: aNode.

				matchBreadthLocally := breadthSpec isExact not and: [ aNode breadthResizer isMatchParent ].
				childBreadth := aNode measuredBreadth + aNode marginBreadth.
				maxBreadth := maxBreadth max: childBreadth.
				alternativeMaxBreadth := (matchBreadthLocally
					ifTrue: [ aNode marginBreadth ]
					ifFalse: [ childBreadth ]) max: alternativeMaxBreadth.
				allFillParent := allFillParent and: [ aNode breadthResizer isMatchParent ].
				
				self processBaseline: aNode breadth: childBreadth ].
			
			totalLength := totalLength + (orientation paddingLength: parent).
			self baselineMeasure ]

		ifFalse: [
			alternativeMaxBreadth := alternativeMaxBreadth max: weightedMaxBreadth.
			
			" We have no limit, so make all weighted views as wide as the largest child.
           Children will have already been measured once."
			(self useLargestChild and: [ self isLengthExact not ])
				ifTrue: [
					self nodes
						select: [ :aNode | aNode weight > 0 ]
						thenDo: [ :aNode |
							aNode measure: (orientation
								extentBreadth: (BlMeasurementSpec exact: aNode measuredBreadth)
								lengthSpec: (BlMeasurementSpec exact: largestChildLength)) ] ] ]
]
