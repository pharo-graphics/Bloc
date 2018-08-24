"
I represent a horizontal or vertical axis of grid layout.

I compute and cache locations of cells within grid along corresponding axis.
I use Bellman-Ford algorithm to solve a set of inequalities in order to distribute indices such that cells of different sizes could fit on the grid within its bounds. 
I'm also responsible for calculation of grid's size based on children and grid resizing mode.

Public API and Key Messages

- applyLayoutIn: entrance point used to launch layout computation process within provided size along axis
- locations returns (creates,  computes and caches) cell locations and sizes along axis and used by GridLayout during measure: and layout:  
- measure: determines grid's size based on cells and grid's resizing mode along axis

   BlGridLayoutAxis new
	horizontal: true
 
Internal Representation and Key Implementation Points.

	Most instance variables are used to cache and store computation results between layout processes. Used to increase performance

    Instance Variables
	arcs:		<Object>
	arcsValid:		<Object>
	backwardLinks:		<Object>
	backwardLinksValid:		<Object>
	definedCount:		<Object>
	deltas:		<Object>
	element:		<Object>
	forwardLinks:		<Object>
	forwardLinksValid:		<Object>
	groupBounds:		<Object>
	groupBoundsValid:		<Object>
	hasWeights:		<Object>
	hasWeightsValid:		<Object>
	isHorizontal:		<Object>
	leadingMargins:		<Object>
	leadingMarginsValid:		<Object>
	locations:		<Object>
	locationsValid:		<Object>
	maxIndex:		<Object>
	orderPreserved:		<Object>
	parentMax:		<Object>
	parentMin:		<Object>
	trailingMargins:		<Object>
	trailingMarginsValid:		<Object>
"
Class {
	#name : #BlGridLayoutAxis,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'layout',
		'isHorizontal',
		'maxIndex',
		'definedCount',
		'orderPreserved',
		'groupBounds',
		'groupBoundsValid',
		'deltas',
		'forwardLinks',
		'forwardLinksValid',
		'backwardLinks',
		'backwardLinksValid',
		'parentMin',
		'parentMax',
		'arcs',
		'arcsValid',
		'leadingMargins',
		'trailingMargins',
		'leadingMarginsValid',
		'trailingMarginsValid',
		'hasWeightsValid',
		'hasWeights',
		'locations',
		'locationsValid',
		'childConstraints',
		'totalMargins'
	],
	#classVars : [
		'COMPLETE',
		'NEW',
		'PENDING'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #'class initialization' }
BlGridLayoutAxis class >> initialize [
	super initialize.
	
	NEW := 0.
	PENDING := 1.
	COMPLETE := 2.
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> addComponentSizesIn: theArcs links: links [
	"arcs is collection of BlGridLayoutArc
	links is BlGridPackedMap<Interval, BlMutableInteger>"
	
	links keysAndValuesDo: [ :span :size |
		self includeIn: theArcs span: span size: size ignoreIfPresent: false ]
]

{ #category : #measure }
BlGridLayoutAxis >> applyLayoutIn: size [

	self parentConstraintsMin: size max: size.
	self locations
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> arcs [

	arcs
		ifNil: [ arcs := self createArcs ].
		
	arcsValid ifFalse: [ 
		self computeArcs.
		arcsValid := true ].
	
	^ arcs
]

{ #category : #'computing links' }
BlGridLayoutAxis >> backwardLinks [
	<return: #'OrderPreservingDictionary<Interval, BlMutableInt>'>
	
	backwardLinks ifNil: [ backwardLinks := self createLinks: false ].
	
	backwardLinksValid ifFalse: [ 
		self computeLinks: backwardLinks min: false.
		backwardLinksValid := true ].
	
	^ backwardLinks
]

{ #category : #computing }
BlGridLayoutAxis >> calculateMaxIndex [
	|result|
	result := -1.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec span |
		spec := (childConstraints at: index) spec.
		span := spec span.
		result := result max: span first.
		result := result max: span last.
		result := result max: span size - 1.
		result := result ].
	^ result < 0
		ifTrue: [ UNDEFINED ]
		ifFalse: [ result ]
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> calculateTotalWeight [

	^ (self element children accountedByLayout inject: 0.0 into: [ :totalWeight :child |
		child visibility shouldLayout
			ifTrue: [ totalWeight + (self specOf: child) weight ]
			ifFalse: [ totalWeight  ] ]) asFloat
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> computeArcs [
	self forwardLinks.
	self backwardLinks.
]

{ #category : #'computing group bounds' }
BlGridLayoutAxis >> computeGroupBounds [

	groupBounds valuesDo: [ :bounds | bounds reset ].
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec size |
		spec := (childConstraints at: index) spec.
		size := self layout measurer measurementWithMarginOf: child isHorizontal: self horizontal.
		size := size + (spec weight = 0
			ifTrue: [ 0 ]
			ifFalse: [ self deltas at: index ]).
		(groupBounds at: index) includeElement: self element spec: spec axis: self size: size ]
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> computeHasWeights [
	
	^ self element children accountedByLayout anySatisfy: [ :child |
			child visibility shouldLayout
				and: [ (self specOf: child) weight isZero not ] ]
]

{ #category : #'computing links' }
BlGridLayoutAxis >> computeLinks: links min: isMin [
	
	links valuesDo: [ :span | span reset ].
	self groupBounds values withIndexDo: [ :bounds :index |
		|size span|
		size := bounds size: isMin.
		span := links at: index.
		span value: (span value max: ( isMin ifTrue: [ size ] ifFalse: [ size negated ] ) ) ].
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> computeLocations: theLocations [

	self hasWeights
		ifFalse: [ self solveLocations: theLocations ]
		ifTrue: [ self solveAndDistributeSpaceLocations: theLocations ].
		
	self isOrderPreserved
		ifTrue: [ ^ self ].
	
	theLocations withIndexDo: [ :location :index |
		theLocations at: index put: (location - theLocations first) ]
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> computeMargins: isLeading [
	| margins |
	
	margins := isLeading
		ifTrue: [ leadingMargins ]
		ifFalse: [ trailingMargins ].

	self element children accountedByLayout withIndexDo: [ :child :anIndex |
		child visibility shouldLayout ifTrue: [ 
			| spec span index margin |
			spec := (childConstraints at: anIndex) spec.
			span := spec span.
			index := isLeading
				ifTrue: [ span first ]
				ifFalse: [ span last ].
			margin := (margins at: index) max: (self layout measurer marginOf: child isHorizontal: self horizontal isLeading: isLeading).
			margins at: index put: margin ] ]
]

{ #category : #computing }
BlGridLayoutAxis >> count [
	^ definedCount max: self maxIndex
]

{ #category : #computing }
BlGridLayoutAxis >> count: aNumber [
	self assert: aNumber isNotNil.
	"self
		assert: (aNumber ~= UNDEFINED and: [ aNumber < self maxIndex ])
		descriptionBlock: [ 'aNumber must be greater or equal to maxIndex (', self maxIndex asString, ') but is ', aNumber asString ]."

	definedCount := aNumber
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> createArcs [
	|mins maxs n sMins sMaxs|
	mins := OrderedCollection new.
	maxs := OrderedCollection new.
	
	self addComponentSizesIn: mins links: self forwardLinks.
	self addComponentSizesIn: maxs links: self backwardLinks.
	
	self isOrderPreserved
		ifTrue: [ 
			1 to: self count do: [ :i |
				self includeIn: mins span: (i to: i + 1) size: (BlGridMutableInteger value: 0) ] ].
		
	n := self count.
	self includeIn: mins span: (1 to: n + 1) size: parentMin ignoreIfPresent: false.
	self includeIn: maxs span: (n + 1 to: 1) size: parentMax ignoreIfPresent: false.
	
	sMins := self topologicalSort: mins.
	sMaxs := self topologicalSort: maxs.
	
	^ sMins, sMaxs
]

{ #category : #'computing group bounds' }
BlGridLayoutAxis >> createGroupBounds [     
	<return: #'BlGridPackedMap<Interval, BlMutableInt>'>      
	|assocs|
	
	assocs := OrderedCollection new.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec bounds |
		spec := (childConstraints at: index) spec.
		bounds := (spec absoluteAlignment: self horizontal) bounds.
		assocs add: (spec -> bounds) ].
	^ BlGridPackedMap fromAssociations: assocs
]

{ #category : #'computing links' }
BlGridLayoutAxis >> createLinks: isMin [
	<return: #'BlGridPackedMap<Interval, BlMutableInt>'>
		
	| links |
	links := OrderedCollection new.
	self groupBounds keysDo: [ :spec |
		| span |
		span := isMin
			ifTrue: [ spec span ]
			ifFalse: [ spec span inversed ].
		links add: (span -> BlGridMutableInteger new) ].
	^ BlGridPackedMap fromAssociations: links
]

{ #category : #initialization }
BlGridLayoutAxis >> defaultOrderPreserved [
	^ true
]

{ #category : #computing }
BlGridLayoutAxis >> definedCount [
	^ definedCount
]

{ #category : #'computing deltas' }
BlGridLayoutAxis >> deltas [
	^ deltas ifNil: [ 
		deltas := Array new: self element children accountedByLayout size withAll: 0 ]
]

{ #category : #accessing }
BlGridLayoutAxis >> element [
	self assert: element isNotNil.
	
	^ element
]

{ #category : #accessing }
BlGridLayoutAxis >> element: anElement [
	self assert: anElement isNotNil.
	
	element := anElement
]

{ #category : #'computing links' }
BlGridLayoutAxis >> forwardLinks [
	<return: #'OrderPreservingDictionary<Interval, BlMutableInt>'>
	
	forwardLinks ifNil: [ forwardLinks := self createLinks: true ].
	
	forwardLinksValid ifFalse: [ 
		self computeLinks: forwardLinks min: true.
		forwardLinksValid := true ].
	
	^ forwardLinks
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> groupArcsByFirstVertex: theArcs [
	"theArcs is collection of BlGridLayoutArc."
	
	| n groups sizes |
	n := self count + 1.
	groups := Array new: n.
	sizes := Array new: n withAll: 0.

	theArcs do: [ :arc |
		sizes at: arc span first incrementBy: 1 ].
	
	sizes withIndexDo: [ :size :index |
		groups at: index put: (Array new: size) ].
	
	sizes := Array new: n withAll: 1.
	theArcs do: [ :arc |
		|index|
		index := arc span first.
		(groups at: index) at: (sizes at: index) put: arc.
		sizes at: index incrementBy: 1 ].
	^ groups
]

{ #category : #'computing group bounds' }
BlGridLayoutAxis >> groupBounds [
	
	groupBounds
		ifNil: [ groupBounds := self createGroupBounds ].
	
	groupBoundsValid ifFalse: [ 
		self computeGroupBounds.
		groupBoundsValid = true ].
	
	^ groupBounds
]

{ #category : #'computing weights' }
BlGridLayoutAxis >> hasWeights [

	hasWeightsValid ifFalse: [ 
		hasWeights := self computeHasWeights.
		hasWeightsValid := true ].
	^ hasWeights
]

{ #category : #accessing }
BlGridLayoutAxis >> horizontal [
	^ isHorizontal
]

{ #category : #accessing }
BlGridLayoutAxis >> horizontal: anObject [
	isHorizontal := anObject
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> includeIn: theArcs span: span size: size [

	self includeIn: theArcs span: span size: size ignoreIfPresent: true
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> includeIn: theArcs span: span size: size ignoreIfPresent: ignoreIfPresent [
	"arcs is collection of BlGridLayoutArc.
	span is Interval
	size is BlMutableInteger
	ignoreIfPresent is Boolean"

	span size = 1
		ifTrue: [ ^ self ].
	
	(ignoreIfPresent
		and: [ theArcs anySatisfy: [ :arc | arc span = span ] ])
			ifTrue: [ ^ self ].
	
	theArcs add: ( BlGridLayoutArc span: span value: size )
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> initLocations: theLocations [
	theLocations atAllPut: 0
]

{ #category : #initialization }
BlGridLayoutAxis >> initialize [
	super initialize.
	
	isHorizontal := false.
	hasWeights := false.
	
	groupBoundsValid := false.
	forwardLinksValid := false.
	backwardLinksValid := false.
	leadingMarginsValid := false.
	trailingMarginsValid := false.
	arcsValid := false.
	hasWeightsValid := false.
	locationsValid := false.
	
	orderPreserved := self defaultOrderPreserved.
	maxIndex := UNDEFINED.
	definedCount := UNDEFINED.
	parentMin := BlGridMutableInteger value: 0.
	parentMax := BlGridMutableInteger new.
]

{ #category : #invalidate }
BlGridLayoutAxis >> invalidateStructure [
	maxIndex := UNDEFINED.

	groupBounds := nil.
	forwardLinks := nil.
	backwardLinks := nil.

	leadingMargins := nil.
	trailingMargins := nil.
	arcs := nil.

	locations := nil.

	deltas := nil.
	hasWeightsValid := false.

	self invalidateValues.
	
	element ifNil: [ ^ self ].
	
	childConstraints := self element children accountedByLayout collect: [ :child |
		self horizontal
			ifTrue: [ child constraints grid horizontal ]
			ifFalse: [ child constraints grid vertical ] ].
		
	"totalMargins := self element managedChildren collect: [ :child |
			self layout measurer totalMarginOf: child isHorizontal: self horizontal ]."
]

{ #category : #invalidate }
BlGridLayoutAxis >> invalidateValues [
	groupBoundsValid := false.
	forwardLinksValid := false.
	backwardLinksValid := false.

	leadingMarginsValid := false.
	trailingMarginsValid := false.
	arcsValid := false.

	locationsValid := false
]

{ #category : #testing }
BlGridLayoutAxis >> isOrderPreserved [
	^ orderPreserved
]

{ #category : #accessing }
BlGridLayoutAxis >> layout [
	^ layout
]

{ #category : #accessing }
BlGridLayoutAxis >> layout: aLayout [
	layout := aLayout
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> leadingMargins [
	
	leadingMargins
		ifNil: [ leadingMargins := Array new: (self count + 1) withAll: 0 ].
		
	leadingMarginsValid ifFalse: [ 
		self computeMargins: true.
		leadingMarginsValid := true ].
	
	^ leadingMargins
]

{ #category : #accessing }
BlGridLayoutAxis >> locations [
	<return: #Array of: #Integer>

	locations ifNil: [
		locations := Array new: self count + 1 withAll: 0 ].
	
	locationsValid ifFalse: [ 
		self computeLocations: locations.
		locationsValid := true ].
	
	^ locations
]

{ #category : #computing }
BlGridLayoutAxis >> maxIndex [
	^ maxIndex == UNDEFINED
		ifTrue: [ maxIndex := 0 max: self calculateMaxIndex ]
		ifFalse: [ maxIndex ]
]

{ #category : #measure }
BlGridLayoutAxis >> measure: aMeasurementSpec [
	| mode size |
	mode := aMeasurementSpec mode.
	size := aMeasurementSpec size.
	
	mode isUnspecified
		ifTrue: [ ^ self measureMin: 0 max: Float infinity ].

	mode isExact
		ifTrue: [ ^ self measureMin: size max: size ].

	mode isAtMost
		ifTrue: [ ^ self measureMin: 0 max: size ].
	
	Warning signal: 'Unknown measurement spec mode: ', mode asString.
	
	^ 0
]

{ #category : #measure }
BlGridLayoutAxis >> measureMin: min max: max [

	self parentConstraintsMin: min max: max.
	^ self sizeLocations: self locations
]

{ #category : #computing }
BlGridLayoutAxis >> orderPreserved: aBoolean [
	self assert: aBoolean isNotNil.
	
	orderPreserved := aBoolean.
	self invalidateStructure
]

{ #category : #'accessing spec' }
BlGridLayoutAxis >> parentConstraintsMin: min max: max [

	parentMin value: min.
	parentMax value: max negated.
	locationsValid := false
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> relaxLocations: theLocations arc: arc [
	"locations is array of integers.
	arc is BlGridLayoutArc"
	<return: #Boolean>
	| span u v value candidate |
	
	arc valid
		ifFalse: [ ^ false ].
	
	span := arc span.
	u := span first.
	v := span last.
	value := arc value value.
	candidate := (theLocations at: u) + value.
	
	^ (candidate > (theLocations at: v))
		ifTrue: [ 
			theLocations at: v put: candidate.
			true ]
		ifFalse: [ false ]
]

{ #category : #'computing deltas' }
BlGridLayoutAxis >> shareOutDelta: totalDelta totalWeight: totalWeight [
	| mTotalDelta mTotalWeight |
	mTotalDelta := totalDelta.
	mTotalWeight := totalWeight.
	
	deltas atAllPut: 0.
	
	self element children accountedByLayout withIndexDo: [ :child :index |
		child visibility shouldLayout ifTrue: [ 
			| spec weight |
			spec := (childConstraints at: index) spec.
			weight := spec weight asFloat.
			weight ~= 0 ifTrue: [ 
				| delta |
				delta := (weight / mTotalWeight * mTotalDelta) rounded.
				deltas at: index put: delta.
				mTotalDelta := mTotalDelta - delta.
				mTotalWeight := mTotalWeight - weight ] ] ]
]

{ #category : #'computing locations' }
BlGridLayoutAxis >> sizeLocations: theLocations [

	^ theLocations at: self count + 1
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solve: theArcs locations: theLocations [
	^ self solve: theArcs locations: theLocations modifyOnError: true
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solve: theArcs locations: theLocations modifyOnError: modifyOnError [
	| n originalCulprits |

	n := self count + 1.
	originalCulprits := nil.
	
	0 to: theArcs size - 1 do: [ :p |
		| culprits i break |
		
		self initLocations: theLocations.
			
		n timesRepeat: [ 
			| changed |
			changed := false.
			
			theArcs do: [ :arc | changed := changed | (self relaxLocations: theLocations arc: arc ) ].
	
			changed ifFalse: [ 
				originalCulprits ifNotNil: [ "Warning signal: 'something is bad'" ].
				^ true ] ].
				
		modifyOnError ifFalse: [ ^ false ]. "can not solve"

		culprits := Array new: theArcs size withAll: false.
				
		n timesRepeat: [ 
			arcs withIndexDo: [ :arc :index |
				| culprit |
				culprit := culprits at: index.
				culprits at: index put: (culprit | ( self relaxLocations: theLocations arc: arc ) ) ] ].

		p = 0 ifTrue: [ originalCulprits := culprits ].
				
		i := 1.
		break := false.
				
		[ i <= theArcs size and: [ break not ] ] whileTrue: [ 
			(culprits at: i) ifTrue: [ 
				| arc |
				arc := theArcs at: i.
			
				(arc span first < arc span last) ifFalse: [
					arc valid: false.
					break := true ]	 ].
				i := i + 1 ] ].
	^ true
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solveAndDistributeSpaceLocations: theLocations [
	| deltaMax deltaMin totalWeight validDelta validSolution |
	self deltas atAllPut: 0.
	self solveLocations: theLocations.
	
	deltaMax := (parentMin value * self element children accountedByLayout size) asFloat.
	deltaMax < 1
		ifTrue: [ ^ self ].

	deltaMin := 0.
	totalWeight := self calculateTotalWeight.
	validDelta := -1.
	validSolution := true.
	[ ((deltaMax - deltaMin)) > 0.0001 ] whileTrue: [ 
		| delta |
		delta := (deltaMin / 2.0) + (deltaMax / 2.0).
		self invalidateValues.
		self shareOutDelta: delta totalWeight: totalWeight.
		validSolution := self solve: self arcs locations: theLocations modifyOnError: false.
		validSolution
			ifTrue: [ 
				validDelta := delta.
				deltaMin := delta + 1.0 ]
			ifFalse: [ deltaMax := delta ] ].
	
	(validDelta > 0 and: [ validSolution not ]) ifTrue: [ 
		self invalidateValues.
		self shareOutDelta: validDelta totalWeight: totalWeight.
		self solveLocations: theLocations ]
]

{ #category : #'computing inequalities' }
BlGridLayoutAxis >> solveLocations: theLocations [
	^ self solve: self arcs locations: theLocations
]

{ #category : #'accessing spec' }
BlGridLayoutAxis >> specOf: anElement [
	^ self horizontal
		ifTrue: [ anElement constraints grid horizontal spec ]
		ifFalse: [ anElement constraints grid vertical spec ]
]

{ #category : #'computing arcs' }
BlGridLayoutAxis >> topologicalSort: theArcs [
	| result cursor arcsByVertex visited walk |
	result := Array new: theArcs size.
	cursor := result size.
	arcsByVertex := self groupArcsByFirstVertex: theArcs.
	visited := Array new: self count + 1 withAll: 0.
	
	walk := nil.
	walk := [ :loc | 
		| status |
		status := visited at: loc.
		status = NEW
			ifTrue: [
				visited at: loc put: PENDING.
				(arcsByVertex at: loc) do: [ :arc |
					walk value: arc span last.
					result at: cursor put: arc.
					cursor := cursor - 1 ].
				visited at: loc put: COMPLETE ].
		status = PENDING
			ifTrue: [ Warning signal: 'Status of visited at ', loc asString, ' should not be PENDING' ] ].
	
	1 to: arcsByVertex size do: [ :loc |
		walk value: loc ].
	
	cursor = 0
		ifFalse: [ Warning signal: 'cursor value should be 0 but was ', cursor asString ].
	
	^ result
]

{ #category : #'computing margins' }
BlGridLayoutAxis >> trailingMargins [
	
	trailingMargins
		ifNil: [ trailingMargins := Array new: (self count + 1) withAll: 0 ].
		
	trailingMarginsValid ifFalse: [ 
		self computeMargins: false.
		trailingMarginsValid := true ].
	
	^ trailingMargins
]
