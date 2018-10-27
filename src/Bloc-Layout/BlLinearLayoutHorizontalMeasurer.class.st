Class {
	#name : #BlLinearLayoutHorizontalMeasurer,
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
		'maxAscent',
		'maxDescent',
		'maxBreadth',
		'allFillParent',
		'weightedMaxBreadth',
		'alternativeMaxBreadth'
	],
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #measuring }
BlLinearLayoutHorizontalMeasurer >> baselineMeasure [
	"I adjust my max breadth based on current max ascent and descent"

	maxAscent ifNotEmpty: [
		| anAscent aDescent |
		
		anAscent := maxAscent values max.
		aDescent := maxDescent values max.
		maxBreadth := maxBreadth max: (anAscent + aDescent) ]
]

{ #category : #accessing }
BlLinearLayoutHorizontalMeasurer >> breadthSpec [
	^ breadthSpec
]

{ #category : #'accessing - properties' }
BlLinearLayoutHorizontalMeasurer >> cellSpacing [
	^ cellSpacing
]

{ #category : #initialization }
BlLinearLayoutHorizontalMeasurer >> initialize [
	super initialize.

	useLargestChild := false.
	isBaselineAligned := false.
	cellSpacing := 0.

	totalLength := 0.
	totalWeight := 0.
	usedExcessSpace := 0.
	skippedMeasure := false.
	matchBreadth := false.
	largestChildLength := 0.
	
	maxAscent := Dictionary new.
	maxDescent := Dictionary new.
	maxBreadth := 0.
	allFillParent := false
]

{ #category : #initialization }
BlLinearLayoutHorizontalMeasurer >> initializeWith: aParentElement extentSpec: anExtentSpec orientation: aBlLinearLayoutOrientation [

	parent := aParentElement.
	orientation := aBlLinearLayoutOrientation.
	
	extentSpec := anExtentSpec.
	breadthSpec := orientation breadthSpec: anExtentSpec.
	lengthSpec := orientation lengthSpec: anExtentSpec.

	nodes := aParentElement children accountedByLayout
		collect: [ :aChildElement | BlLinearLayoutNode new initializeWith: aChildElement orientation: orientation ]
]

{ #category : #'accessing - properties' }
BlLinearLayoutHorizontalMeasurer >> isBaselineAligned [
	^ isBaselineAligned
]

{ #category : #testing }
BlLinearLayoutHorizontalMeasurer >> isBreadthExact [
	^ self breadthSpec isExact
]

{ #category : #testing }
BlLinearLayoutHorizontalMeasurer >> isLengthExact [
	^ self lengthSpec isExact
]

{ #category : #measuring }
BlLinearLayoutHorizontalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all weighted children to have the minimum size of the largest child"
	
	self useLargestChild
		ifFalse: [ ^ self ].
	
	(lengthSpec isAtMost or: [ lengthSpec isUnspecified ])
		ifFalse: [ ^ self ].
	
	totalLength := 0.
	
	self nodes do: [ :aNode |
		totalLength := self isBreadthExact
			ifTrue: [ totalLength + largestChildLength + aNode marginLength ]
			ifFalse: [ totalLength max: (totalLength + largestChildLength + aNode marginLength) ] ]
]

{ #category : #accessing }
BlLinearLayoutHorizontalMeasurer >> lengthSpec [
	^ lengthSpec
]

{ #category : #measuring }
BlLinearLayoutHorizontalMeasurer >> measure [
	self preMeasure.

	self baselineMeasure.
	self largestMeasure.

	totalLength := totalLength + (orientation paddingLength: parent).
	
	self weightedMeasure
]

{ #category : #accessing }
BlLinearLayoutHorizontalMeasurer >> nodes [
	<return: #Collection of: #BlLinearLayoutNode>

	^ nodes
]

{ #category : #accessing }
BlLinearLayoutHorizontalMeasurer >> parent [
	^ parent
]

{ #category : #measuring }
BlLinearLayoutHorizontalMeasurer >> preMeasure [

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
				| childBaseline childAlignment |

				childBaseline := aNode element baselineOffset.
				childAlignment := aNode verticalAlignment ifNull: [ parent layout verticalAlignment ].
				
				maxAscent
					at: childAlignment
					ifPresent: [ :anAscent | maxAscent at: childAlignment put: (anAscent max: childBaseline)  ]
					ifAbsentPut: [ childBaseline ].
				maxDescent
					at: childAlignment
					ifPresent: [ :aDescent | maxDescent at: childAlignment put: (aDescent max: childBreadth - childBaseline)  ]
					ifAbsentPut: [ childBreadth - childBaseline ] ].
				
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

{ #category : #'accessing - properties' }
BlLinearLayoutHorizontalMeasurer >> remainingWeightSum [
	<return: #Number>

	^ self weightSum > 0
		ifTrue: [ self weightSum ]
		ifFalse: [ totalWeight ]
]

{ #category : #'accessing - properties' }
BlLinearLayoutHorizontalMeasurer >> useLargestChild [
	^ useLargestChild
]

{ #category : #'accessing - properties' }
BlLinearLayoutHorizontalMeasurer >> weightSum [
	^ parent layout weightSum
]

{ #category : #measuring }
BlLinearLayoutHorizontalMeasurer >> weightedMeasure [
	"I measure weighted children if there is enough excess space"	
	| lengthSize remainingExcess |

	"Check against our minimum length"
	lengthSize := totalLength max: (orientation minimalLength: parent).
	
	"Reconcile our calculated size with the lengthSpec"
	lengthSize := lengthSpec sizeFor: lengthSize.
	
	"Either expand children with weight to take up available space or shrink them if they extend beyond our current bounds.
	If we skipped measurement on any children, we need to measure them now."
	remainingExcess := lengthSize - totalLength + usedExcessSpace.
	
	(skippedMeasure or: [ remainingExcess > 0 and: [ totalWeight > 0 ] ])
		ifTrue: [
			| remainingWeightSum |
			
			remainingWeightSum := self remainingWeightSum.
			
			maxAscent removeAll.
			maxDescent removeAll.
			maxBreadth := 0.
			totalLength := 0.
			
			self nodes do: [ :aNode |
				| childWeight childLength childBreadth matchBreadthLocally |
				
				childWeight := aNode weight.
				childWeight > 0
					ifTrue: [
						| shareSpace childLengthSpec childBreadthSpec |
						
						shareSpace := (childWeight * remainingExcess / remainingWeightSum) asInteger.
						remainingExcess := remainingExcess - shareSpace.
						remainingWeightSum := remainingWeightSum - childWeight.
						
						childLength := (self useLargestChild and: [ self isLengthExact not ])
							ifTrue: [ largestChildLength ]
							ifFalse: [ aNode breadthResizer isMatchParent
								"This child needs to be laid out from scratch using only its share of excess space."
								ifTrue: [ shareSpace ]
								"This child had some intrinsic width to which we need to add its share of excess space."
								ifFalse: [ aNode measuredLength + shareSpace ] ].
							
						childLengthSpec := BlMeasurementSpec exact: (0 max: childLength).
						childBreadthSpec := parent layout
							measurementSpecFor: breadthSpec
							usedSize: (orientation paddingBreadth: parent) + (aNode marginBreadth)
							resizer: aNode breadthResizer.
							
						 aNode measure: (orientation extentSpecBreadth: childBreadthSpec lengthSpec: childLengthSpec) ].
				
				totalLength := self isLengthExact
					ifTrue: [ totalLength + aNode measuredLength + aNode marginLength ]
					ifFalse: [ totalLength max: (totalLength + aNode measuredLength + aNode marginLength) ].

				matchBreadthLocally := breadthSpec isExact not and: [ aNode breadthResizer isMatchParent ].
				childBreadth := aNode measuredBreadth + aNode marginBreadth.
				maxBreadth := maxBreadth max: childBreadth.
				alternativeMaxBreadth := (matchBreadthLocally
					ifTrue: [ aNode marginBreadth ]
					ifFalse: [ childBreadth ]) max: alternativeMaxBreadth.
			]
		
		]
		ifFalse: [  ]
		
	







]
