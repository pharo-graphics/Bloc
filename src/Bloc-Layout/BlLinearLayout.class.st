Class {
	#name : #BlLinearLayout,
	#superclass : #BlLayout,
	#traits : 'TBlAlignable + TObservable',
	#classTraits : 'TBlAlignable classTrait + TObservable classTrait',
	#instVars : [
		'#weightSum',
		'#verticalAlignment',
		'#horizontalAlignment',
		'#orientation => ObservableSlot',
		'#shouldUseLargestChild',
		'#cellSpacing',
		'#direction => ObservableSlot'
	],
	#category : #'Bloc-Layout-Linear'
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

{ #category : #comparing }
BlLinearLayout >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ weightSum = anObject weightSum
		and: [ verticalAlignment = anObject verticalAlignment
				and: [ shouldUseLargestChild = anObject shouldUseLargestChild
						and: [ orientation = anObject orientation
								and: [ horizontalAlignment = anObject horizontalAlignment
										and: [ direction = anObject direction
												and: [ cellSpacing = anObject cellSpacing ] ] ] ] ] ]
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
BlLinearLayout >> cellSpacing [
	<return: #Number>
	
	^ cellSpacing
]

{ #category : #accessing }
BlLinearLayout >> cellSpacing: aNumber [	
	cellSpacing := aNumber asFloat
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

{ #category : #'api - direction' }
BlLinearLayout >> direction [

	^ direction ifNil: [ self defaultDirection ]
]

{ #category : #'api - direction' }
BlLinearLayout >> direction: aBlLayoutDirection [

	direction := aBlLayoutDirection
]

{ #category : #comparing }
BlLinearLayout >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ weightSum hash
		bitXor:
			(verticalAlignment hash
				bitXor:
					(shouldUseLargestChild hash
						bitXor:
							(orientation hash
								bitXor:
									(horizontalAlignment hash
										bitXor: (direction hash bitXor: cellSpacing hash)))))
]

{ #category : #accessing }
BlLinearLayout >> horizontalAlignment [
	^ horizontalAlignment
]

{ #category : #accessing }
BlLinearLayout >> horizontalAlignment: anAlignment [
	horizontalAlignment := anAlignment
]

{ #category : #initialization }
BlLinearLayout >> initialize [

	self class initializeSlots: self.
	super initialize.

	weightSum := self defaultWeightSum.
	shouldUseLargestChild := false.
	cellSpacing := 0.0.
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.

	self orientation: self defaultOrientation
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
BlLinearLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	self orientation layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext.
	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext
]

{ #category : #'api - direction' }
BlLinearLayout >> leftToRight [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #measure }
BlLinearLayout >> measure: anElement with: anExtentSpec [
	| aMeasurer |
	"I measure a new extent of myself and my children"
	
	aMeasurer := self orientation isHorizontal
		ifTrue: [ BlLinearLayoutHorizontalMeasurer new ]
		ifFalse: [ BlLinearLayoutVerticalMeasurer new ].
		
	aMeasurer
		initializeWith: anElement
		layout: self
		extentSpec: anExtentSpec
		orientation: self orientation.
	
	aMeasurer measureOn: anElement.
	
	self measureIgnored: anElement with: (BlExtentMeasurementSpec exact: anElement measuredExtent)
]

{ #category : #accessing }
BlLinearLayout >> orientation [
	^ orientation
]

{ #category : #accessing }
BlLinearLayout >> orientation: anOrientation [

	anOrientation layout: self.
	orientation := anOrientation.

]

{ #category : #'api - direction' }
BlLinearLayout >> rightToLeft [

	self direction: BlLayoutDirection rightToLeft
]

{ #category : #testing }
BlLinearLayout >> shouldUseLargestChild [
	"When true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally."
	<return: #Boolean>

	^ shouldUseLargestChild
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
	<return: #Number>

	^ weightSum
]

{ #category : #accessing }
BlLinearLayout >> weightSum: aNumber [
	weightSum := aNumber asFloat
]

{ #category : #'slot change hook' }
BlLinearLayout >> whenDirectionChangedDo: aBlock [

	"Inform when lineMode property has changed.
	 `aBlock` has three optional arguments:
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #direction whenChangedDo: aBlock
]

{ #category : #'slot change hook' }
BlLinearLayout >> whenOrientationChangedDo: aBlock [

	"Inform when lineMode property has changed.
	 `aBlock` has three optional arguments:
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #orientation whenChangedDo: aBlock
]

{ #category : #'api - configuration' }
BlLinearLayout >> withSpaceEqualization [
	"When set to true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally.
	Disabled by default."

	shouldUseLargestChild := true
]

{ #category : #'api - configuration' }
BlLinearLayout >> withoutSpaceEqualization [
	"When set to true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally.
	Disabled by default."

	shouldUseLargestChild := false
]
