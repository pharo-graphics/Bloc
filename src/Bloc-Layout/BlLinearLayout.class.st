"
Notes:
-  may need the notion of spacing to define a space between all elements without to be forced to assign a margin for each ones.
- how to distribute elements equally in the parent bounds ?
"
Class {
	#name : #BlLinearLayout,
	#superclass : #BlLayout,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'weightSum',
		'verticalAlignment',
		'horizontalAlignment',
		'cache',
		'orientation'
	],
	#category : 'Bloc-Layout-Linear'
}

{ #category : #constraints }
BlLinearLayout class >> constraints [
	^ BlLinearLayoutConstraints new
]

{ #category : #factory }
BlLinearLayout class >> horizontal [
	^ self new beHorizontal
]

{ #category : #factory }
BlLinearLayout class >> vertical [
	^ self new beVertical
]

{ #category : #'api - alignment' }
BlLinearLayout >> align: aChildElement horizontal: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]
]

{ #category : #'api - alignment' }
BlLinearLayout >> align: aChildElement vertical: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]
]

{ #category : #accessing }
BlLinearLayout >> alignment [
	^ (self horizontalAlignment + self verticalAlignment) directed: self direction
]

{ #category : #orientation }
BlLinearLayout >> beHorizontal [
	"Change my orientation to horizontal"
	
	self orientation: BlLinearLayoutHorizontalOrientation new
]

{ #category : #orientation }
BlLinearLayout >> beVertical [
	"Change my orientation to vertical"
	
	self orientation: BlLinearLayoutVerticalOrientation new
]

{ #category : #accessing }
BlLinearLayout >> cache [
	^ cache
]

{ #category : #initialization }
BlLinearLayout >> defaultCache [
	"Return default cache to store temporary variable used during measurement and layouting process"
	<return: #BlLinearLayoutCache>
	
	^ BlLinearLayoutCache new
]

{ #category : #initialization }
BlLinearLayout >> defaultHorizontalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null horizontal
]

{ #category : #initialization }
BlLinearLayout >> defaultOrientation [
	"Return default orientation used by LinearLayout. If
	instance of my class is created with #new a horizontal orientation
	is used by defualt"
	<return: #BlLinearLayoutHorizontalOrientation>
	
	^ BlLinearLayoutHorizontalOrientation new
]

{ #category : #initialization }
BlLinearLayout >> defaultVerticalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null vertical
]

{ #category : #initialization }
BlLinearLayout >> defaultWeightSum [
	"Default weight sum should be 0 to indicate that actual weight should be calculated
	as arithmetic sum of childrens' weight"
	<return: #Number>
	
	^ 0
]

{ #category : #testing }
BlLinearLayout >> hasAnyMatchingParent: anElement [
	"Return true if any of element's children want to match parent among breadth axis, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.

	^ anElement children accountedByLayout anySatisfy: [ :child | (self orientation breadthProperties: child) resizer isMatchParent ]
]

{ #category : #testing }
BlLinearLayout >> hasSkippedNaiveMeasurements: anElement [
	"Return true if any of anElement's children was skipped
	during naive measurement pass, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ anElement children accountedByLayout anySatisfy: [ :child | self shouldSkipNaiveMeasure: child ]
]

{ #category : #accessing }
BlLinearLayout >> horizontalAlignment [
	^ horizontalAlignment
]

{ #category : #accessing }
BlLinearLayout >> horizontalAlignment: anAlignment [
	horizontalAlignment := anAlignment
]

{ #category : #measure }
BlLinearLayout >> improvedMeasure: anElement [
	| currentWeightSum deltaLength |
	
	deltaLength := self cache length - self cache totalLength.
	currentWeightSum := self weightSum > 0
		ifTrue: [ self weightSum ]
		ifFalse: [ self cache totalWeight ].
	"because we perform improved measurement we need to recalculate totalLength"
	self cache totalLength: 0.

	self measuredChildren: anElement do: [ :child |
		| marginBreadth marginLength measuredBreadth childMatchBreadth childConstraints |
		childConstraints := child constraints linear.
		marginBreadth := self orientation marginBreadth: child.
		marginLength := self orientation marginLength: child.
		"improve children that match parent along length axis"
		(self orientation lengthProperties: child) resizer isMatchParent ifTrue: [ 
			| sharedLength childBreadthSpec |
			"compute child's length it takes depending on weight"
			sharedLength := (childConstraints weight * deltaLength / currentWeightSum) asFloat.
			"reduce current weight and delta length for the next iteration"
			currentWeightSum := currentWeightSum - childConstraints weight.
			deltaLength := deltaLength - sharedLength.
			"take child's margin into account and check against negative values"
			sharedLength := (sharedLength - marginLength) max: 0.
			"create new width measurement spec, as we already know it (at least approximately)"
			childBreadthSpec := self
				measurementSpecFor: self orientation breadthSpec
				usedSize: (self orientation paddingBreadth: anElement) + marginBreadth
				resizer: (self orientation breadthProperties: child) resizer.
			
			"depending on anElement's length mode measure child differently"
			self orientation lengthMode isExact
				ifFalse: [
					| childLength |
					"If anElement does not know its exact length we can't tell
					what length child should have if it matches parent, so we just
					measure as it is reusing measured length from previous measuring pass"
					childLength := (self orientation measuredLength: child) + sharedLength.
					childLength := childLength max: 0.
					child measure: (self orientation
						extentSpecBreadth: childBreadthSpec
						lengthSpec: (BlMeasurementSpec new
							beExact: childLength)) ]
				ifTrue: [
					"if anElement knows height exactly we can measure
					child instantly giving it as much space as it wants"
					child measure: (self orientation 
						extentSpecBreadth: childBreadthSpec
						lengthSpec: (BlMeasurementSpec new
							beExact: (sharedLength max: 0))) ] ].
		"// End of ifMatchParent: block //"
		
		"if child matches parent along breadth axis we can not say its breadth,
		so if it is the case just use margin breadth as breadth"
		(self orientation breadthProperties: child) resizer isMatchParent
			ifFalse: [ measuredBreadth := (self orientation measuredBreadth: child) + marginBreadth ]
			ifTrue: [ measuredBreadth := marginBreadth ].
			
		self cache maxBreadth: (self cache maxBreadth max: measuredBreadth).
		childMatchBreadth := self orientation breadthMode isExact not and: [ (self orientation breadthProperties: child) resizer isMatchParent ].
				
		self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: (childMatchBreadth ifTrue: [ marginBreadth ] ifFalse: [ measuredBreadth ] ) ).
		self cache totalLength: (self cache totalLength max: (self cache totalLength + (self orientation measuredLength: child) + marginLength)).
	].
	self cache totalLength: (self cache totalLength + (self orientation paddingLength: anElement))
]

{ #category : #initialization }
BlLinearLayout >> initialize [
	super initialize.
	
	weightSum := self defaultWeightSum.
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.
	cache := self defaultCache.
	
	self orientation: self defaultOrientation.
]

{ #category : #testing }
BlLinearLayout >> isHorizontal [
	^ self orientation isHorizontal
]

{ #category : #testing }
BlLinearLayout >> isVertical [
	^ self orientation isVertical
]

{ #category : #layout }
BlLinearLayout >> layout: anElement in: aRectangle [
	self orientation layout: anElement in: aRectangle.
	self layoutIgnored: anElement
]

{ #category : #measure }
BlLinearLayout >> matchingMeasure: anElement [
	"Measure children of anElement that match breadth of anElement"
	| matchingMeasureSpec |
	"create a measurement spec with exact size equal to element's measured breadth"
	matchingMeasureSpec := BlMeasurementSpec new beExact: (self orientation measuredBreadth: anElement).
	
	self measuredChildren: anElement do: [ :child |
		"we measure only those who match parent along breadth axis"
		(self orientation breadthProperties: child) resizer ifMatchParent: [
			|oldResizing|
			"store vertical resizing of child. It can be anything,
			but to success matching it should be exact and equal to already
			measured length"
			oldResizing := (self orientation lengthProperties: child) resizer.
			"switch resizing mode to exact"
			(self orientation lengthProperties: child) exact: (self orientation measuredLength: child).
			"measure child with parent's length spec and our created matching spec 
			in a role of breadth spec"
			self orientation 
				measureChildWithMargin: child
				parentSpec: (self orientation 
					extentSpecBreadth: matchingMeasureSpec
					lengthSpec: self orientation lengthSpec)
				breadthUsed: 0
				lengthUsed: 0.
			"restore previous resizing"
			(self orientation lengthProperties: child) resizer: oldResizing ] ]
]

{ #category : #measure }
BlLinearLayout >> measure: anElement with: anExtentSpec [
	"I measure a new extent of myself and my children"
	
	self cache initializeCaches: anElement with: anExtentSpec.
	
	self
		assert: [ self cache heightMode isNotNil ]
		description: [ 'Height mode must not be nil' ].
		
	self
		assert: [ self cache widthMode isNotNil ]
		description: [ 'Width mode must not be nil' ].
	
	"first perform naive pass to measure children who already know their size"
	self naiveMeasure: anElement with: anExtentSpec.
	
	"total length does not include padding so add it here"
	self cache totalLength: self cache totalLength + (self orientation paddingLength: anElement).
	"apply minimal length restriction on total length. we should not loose
	total length, as it will be needed during improved measurement pass"
	self cache length: (self cache totalLength max: (self orientation minimalLength: anElement)).
	"length should be passed through length measurement spec to be
	more precise specified"
	self cache length: (self orientation lengthSpec sizeFor: self cache length).
	"second smarter pass to measure skipped elements during previous pass"
	(self needsImprovedMeasure: anElement)
		ifTrue: [ self improvedMeasure: anElement ]
		ifFalse: [ self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: self cache matchingMaxBreadth) ].
	
	((self hasAnyMatchingParent: anElement) or: [ self orientation breadthMode isExact ])
		ifTrue: [ self cache maxBreadth: self cache alternativeMaxBreadth ].
	
	"max breadth does not include padding, need to add it"
	self cache maxBreadth: self cache maxBreadth + (self orientation paddingBreadth: anElement).
	"apply minimal breadth restriction"
	self cache maxBreadth: (self cache maxBreadth max: (self orientation minimalBreadth: anElement)).
	"now we finally know anElement's extent and can apply it"
	anElement measuredExtent: (self orientation
		extentBreadth: (self orientation breadthSpec sizeFor: self cache maxBreadth)
		lengthSpec: self cache length).
	
	"if there were children that match parent's breadth we should measure them now"
	self cache matchBreadth ifTrue: [
		self matchingMeasure: anElement ].
	
	"release caches used during measurement and shared between procedures"
	self cache releaseCaches.
	
	self measureIgnored: anElement with: (BlExtentMeasurementSpec exact: anElement measuredExtent)
]

{ #category : #measure }
BlLinearLayout >> measuredBreadthWithMargin: anElement [
	"Return measured Breadth of an element with breadth margin.
	Used during measuring pass.
	If anElement has resizing set to match parent
	return only margin, otherwise measured breadth plus margin.
	anElement must not be nil"
	<return: #Number>
	self assert: anElement isNotNil.
	
	^ ((self orientation breadthProperties: anElement) resizer isMatchParent
			ifFalse: [ self orientation measuredBreadth: anElement ]
			ifTrue: [ 0 ]) + (self orientation marginBreadth: anElement).
]

{ #category : #measure }
BlLinearLayout >> naiveMeasure: anElement with: anExtentMeasurementSpec [
	"First naive pass to measure children with exact dimension or those who wrap to content"

	self measuredChildren: anElement do: [ :child |
		| childMatchBreadth measuredBreadth matchingBreadth childConstraints |
		childConstraints := child constraints linear.
		"we need a local flag to know if one particular child want to match breadth of a parent.
		there is a global flag to detect if any of the children wants to match breadth"
		childMatchBreadth := false.

		"We care about weight only if child is matching parent"
		(self orientation lengthProperties: child) resizer
			ifMatchParent: [ self cache totalWeight: self cache totalWeight + childConstraints weight ].

		"Measure child during first pass if we don't skip it"
		(self shouldSkipNaiveMeasure: child)
			ifFalse: [
				self orientation 
					measureChildWithMargin: child
					parentSpec: anExtentMeasurementSpec
					breadthUsed: 0
					lengthUsed: (self cache totalWeight = 0 ifTrue: [ self cache totalLength ] ifFalse: [ 0 ]).
				"we use max: to not mess up with negative margin values (some layouts may support negative margin)"
				self cache totalLength: (self cache totalLength max: (self cache totalLength + (self orientation measuredLength: child) + (self orientation marginLength: child))) ].
		
		"update corresponding breadth matching flags if we have complicated case"
		(self needsToMatchBreadth: child) 
			ifTrue: [
				self cache matchBreadth: true.
				childMatchBreadth := true ].

		"get child's measured breadth with margin taking into account.
		if child wants to match parent measured breadth is just margin"
		measuredBreadth := self measuredBreadthWithMargin: child.

		"update max breadth of all children based on child's measured breadth.
		we will need it later for the case if parent wants to wrap content horizontally"
		self cache maxBreadth: (self cache maxBreadth max: measuredBreadth).

		"for convenience store a breadth which is to update weighted and alternative max breadth"
		matchingBreadth := childMatchBreadth ifTrue: [ (self orientation marginBreadth: child) ] ifFalse: [ measuredBreadth ].
		(self orientation lengthProperties: child) resizer isMatchParent
			ifTrue: [ self cache matchingMaxBreadth: (self cache matchingMaxBreadth max: matchingBreadth) ]
			ifFalse: [ self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: matchingBreadth) ] ]
]

{ #category : #testing }
BlLinearLayout >> needsImprovedMeasure: anElement [
	"Return true if children of anElement need second measuring pass, false otherwise.
	Improved measure is often needed if any of children wants to match parent or we
	skipped some elements during naive measurement pass
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ (self hasSkippedNaiveMeasurements: anElement) or: [ self cache length ~= self cache totalLength and: [ self cache totalWeight > 0 ] ]
]

{ #category : #testing }
BlLinearLayout >> needsToMatchBreadth: anElement [
	"Return true if anElement wants to match breadth of parent during improved measurement pass, false otherwise.
	During naive measurement we assume that we have a simple case when parent already knows its breadth (breadth mode is exact).
	In simple case so we can match breadth of children instantly without need of second pass.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ self orientation breadthMode isExact not and: [ (self orientation breadthProperties: anElement) resizer isMatchParent ]
]

{ #category : #accessing }
BlLinearLayout >> orientation [
	^ orientation
]

{ #category : #accessing }
BlLinearLayout >> orientation: anOrientation [
	orientation := anOrientation.
	anOrientation applyLayoutIn: self
]

{ #category : #testing }
BlLinearLayout >> shouldSkipNaiveMeasure: anElement [
	"Return true if anElement should not be measured during first
	naive pass, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ self orientation lengthMode isExact
		and: [ (self orientation lengthProperties: anElement) resizer isMatchParent ]
]

{ #category : #accessing }
BlLinearLayout >> verticalAlignment [
	^ verticalAlignment
]

{ #category : #accessing }
BlLinearLayout >> verticalAlignment: anAlignment [
	verticalAlignment := anAlignment
]

{ #category : #accessing }
BlLinearLayout >> weightSum [
	^ weightSum
]

{ #category : #accessing }
BlLinearLayout >> weightSum: anObject [
	weightSum := anObject
]
