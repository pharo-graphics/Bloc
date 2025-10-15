Class {
	#name : #BlBoundsMatcherConstraints,
	#superclass : #BlBitflags,
	#classVars : [
		'ChildEndAndParentEnd',
		'ChildEndAndParentStart',
		'ChildEndEqualParentEnd',
		'ChildEndEqualParentStart',
		'ChildEndGreaterThanParentEnd',
		'ChildEndGreaterThanParentStart',
		'ChildEndLessThanParentEnd',
		'ChildEndLessThanParentStart',
		'ChildStartAndParentEnd',
		'ChildStartAndParentStart',
		'ChildStartEqualParentEnd',
		'ChildStartEqualParentStart',
		'ChildStartGreaterThanParentEnd',
		'ChildStartGreaterThanParentStart',
		'ChildStartLessThanParentEnd',
		'ChildStartLessThanParentStart',
		'Equal',
		'GreaterThan',
		'LessThan',
		'Mask'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndAndParentEnd [
	"This method was automatically generated"
	^ ChildEndAndParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndAndParentStart [
	"This method was automatically generated"
	^ ChildEndAndParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndEqualParentEnd [
	"This method was automatically generated"
	^ ChildEndEqualParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndEqualParentStart [
	"This method was automatically generated"
	^ ChildEndEqualParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndGreaterThanParentEnd [
	"This method was automatically generated"
	^ ChildEndGreaterThanParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndGreaterThanParentStart [
	"This method was automatically generated"
	^ ChildEndGreaterThanParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndLessThanParentEnd [
	"This method was automatically generated"
	^ ChildEndLessThanParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildEndLessThanParentStart [
	"This method was automatically generated"
	^ ChildEndLessThanParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartAndParentEnd [
	"This method was automatically generated"
	^ ChildStartAndParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartAndParentStart [
	"This method was automatically generated"
	^ ChildStartAndParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartEqualParentEnd [
	"This method was automatically generated"
	^ ChildStartEqualParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartEqualParentStart [
	"This method was automatically generated"
	^ ChildStartEqualParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartGreaterThanParentEnd [
	"This method was automatically generated"
	^ ChildStartGreaterThanParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartGreaterThanParentStart [
	"This method was automatically generated"
	^ ChildStartGreaterThanParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartLessThanParentEnd [
	"This method was automatically generated"
	^ ChildStartLessThanParentEnd value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> ChildStartLessThanParentStart [
	"This method was automatically generated"
	^ ChildStartLessThanParentStart value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> Equal [
	"This method was automatically generated"
	^ Equal value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> GreaterThan [
	"This method was automatically generated"
	^ GreaterThan value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> LessThan [
	"This method was automatically generated"
	^ LessThan value
]

{ #category : #'accessing - flags' }
BlBoundsMatcherConstraints class >> Mask [
	"This method was automatically generated"
	^ Mask value
]

{ #category : #'flags declaration' }
BlBoundsMatcherConstraints class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	
	^ {
		#GreaterThan -> (1 << 0).
		#Equal -> (1 << 1).
		#LessThan -> (1 << 2).
		
		#ChildStartAndParentStart -> 0.

		"The child's start should be strictly greater than parent's start."
		#ChildStartGreaterThanParentStart -> [ :d | (d at: #GreaterThan) << (d at: #ChildStartAndParentStart) ].
	
		"The child's start should be equal to parent's start. It can be combined with greater than
		or less than to create `greater than or equal` constraint"
		#ChildStartEqualParentStart -> [ :d | (d at: #Equal) << (d at: #ChildStartAndParentStart) ].
		
		"The child's start should be strictly less than parent's start."
		#ChildStartLessThanParentStart -> [ :d | (d at: #LessThan) << (d at: #ChildStartAndParentStart) ].
		
		#ChildStartAndParentEnd -> 4.
	
		"The child's start should be strictly greater than parent's end."
		#ChildStartGreaterThanParentEnd -> [ :d | (d at: #GreaterThan) << (d at: #ChildStartAndParentEnd) ].
	
		"The child's start should be equal to parent's end. It can be combined with greater than
		or less than to create `greater than or equal` constraint"
		#ChildStartEqualParentEnd -> [ :d | (d at: #Equal) << (d at: #ChildStartAndParentEnd) ].
		
		"The child's start should be strictly less than parent's end."
		#ChildStartLessThanParentEnd -> [ :d | (d at: #LessThan) << (d at: #ChildStartAndParentEnd) ].
		
		#ChildEndAndParentStart -> 8.

		"The child's end should be strictly greater than parent's start."
		#ChildEndGreaterThanParentStart -> [ :d | (d at: #GreaterThan) << (d at: #ChildEndAndParentStart) ].
	
		"The child's end should be equal to parent's start. It can be combined with greater than
		or less than to create `greater than or equal` constraint"
		#ChildEndEqualParentStart -> [ :d | (d at: #Equal) << (d at: #ChildEndAndParentStart) ].
		
		"The child's end should be strictly less than parent's start."
		#ChildEndLessThanParentStart -> [ :d | (d at: #LessThan) << (d at: #ChildEndAndParentStart) ].
		
		#ChildEndAndParentEnd -> 12.

		"The child's end should be strictly greater than parent's end."
		#ChildEndGreaterThanParentEnd -> [ :d | (d at: #GreaterThan) << (d at: #ChildEndAndParentEnd) ].
	
		"The child's end should be equal to parent's end. It can be combined with greater than
		or less than to create `greater than or equal` constraint"
		#ChildEndEqualParentEnd -> [ :d | (d at: #Equal) << (d at: #ChildEndAndParentEnd) ].
		
		"The child's end should be strictly less than parent's end."
		#ChildEndLessThanParentEnd -> [ :d | (d at: #LessThan) << (d at: #ChildEndAndParentEnd) ].
		
		#Mask -> [ :d | (d at: #GreaterThan) | (d at: #Equal) | (d at: #LessThan) ]
	}
]

{ #category : #'class initialization' }
BlBoundsMatcherConstraints class >> initialize [
	"this method is needed else the information is not created. 
	This is the sign of a bad design.
	"
	super initialize.
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndAndParentEnd [
	"This method was automatically generated"
	value := value | ChildEndAndParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndAndParentStart [
	"This method was automatically generated"
	value := value | ChildEndAndParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndEqualParentEnd [
	"This method was automatically generated"
	value := value | ChildEndEqualParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndEqualParentStart [
	"This method was automatically generated"
	value := value | ChildEndEqualParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndGreaterThanParentEnd [
	"This method was automatically generated"
	value := value | ChildEndGreaterThanParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndGreaterThanParentStart [
	"This method was automatically generated"
	value := value | ChildEndGreaterThanParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndLessThanParentEnd [
	"This method was automatically generated"
	value := value | ChildEndLessThanParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildEndLessThanParentStart [
	"This method was automatically generated"
	value := value | ChildEndLessThanParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartAndParentEnd [
	"This method was automatically generated"
	value := value | ChildStartAndParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartAndParentStart [
	"This method was automatically generated"
	value := value | ChildStartAndParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartEqualParentEnd [
	"This method was automatically generated"
	value := value | ChildStartEqualParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartEqualParentStart [
	"This method was automatically generated"
	value := value | ChildStartEqualParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartGreaterThanParentEnd [
	"This method was automatically generated"
	value := value | ChildStartGreaterThanParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartGreaterThanParentStart [
	"This method was automatically generated"
	value := value | ChildStartGreaterThanParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartLessThanParentEnd [
	"This method was automatically generated"
	value := value | ChildStartLessThanParentEnd value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addChildStartLessThanParentStart [
	"This method was automatically generated"
	value := value | ChildStartLessThanParentStart value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addEqual [
	"This method was automatically generated"
	value := value | Equal value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addGreaterThan [
	"This method was automatically generated"
	value := value | GreaterThan value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addLessThan [
	"This method was automatically generated"
	value := value | LessThan value
]

{ #category : #'flags - add' }
BlBoundsMatcherConstraints >> addMask [
	"This method was automatically generated"
	value := value | Mask value
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndAndParentEnd [
	"This method was automatically generated"
	value := value & (ChildEndAndParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndAndParentStart [
	"This method was automatically generated"
	value := value & (ChildEndAndParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndEqualParentEnd [
	"This method was automatically generated"
	value := value & (ChildEndEqualParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndEqualParentStart [
	"This method was automatically generated"
	value := value & (ChildEndEqualParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndGreaterThanParentEnd [
	"This method was automatically generated"
	value := value & (ChildEndGreaterThanParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndGreaterThanParentStart [
	"This method was automatically generated"
	value := value & (ChildEndGreaterThanParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndLessThanParentEnd [
	"This method was automatically generated"
	value := value & (ChildEndLessThanParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildEndLessThanParentStart [
	"This method was automatically generated"
	value := value & (ChildEndLessThanParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartAndParentEnd [
	"This method was automatically generated"
	value := value & (ChildStartAndParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartAndParentStart [
	"This method was automatically generated"
	value := value & (ChildStartAndParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartEqualParentEnd [
	"This method was automatically generated"
	value := value & (ChildStartEqualParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartEqualParentStart [
	"This method was automatically generated"
	value := value & (ChildStartEqualParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartGreaterThanParentEnd [
	"This method was automatically generated"
	value := value & (ChildStartGreaterThanParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartGreaterThanParentStart [
	"This method was automatically generated"
	value := value & (ChildStartGreaterThanParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartLessThanParentEnd [
	"This method was automatically generated"
	value := value & (ChildStartLessThanParentEnd value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearChildStartLessThanParentStart [
	"This method was automatically generated"
	value := value & (ChildStartLessThanParentStart value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearEqual [
	"This method was automatically generated"
	value := value & (Equal value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearGreaterThan [
	"This method was automatically generated"
	value := value & (GreaterThan value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearLessThan [
	"This method was automatically generated"
	value := value & (LessThan value bitInvert)
]

{ #category : #'flags - clear' }
BlBoundsMatcherConstraints >> clearMask [
	"This method was automatically generated"
	value := value & (Mask value bitInvert)
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndAndParentEnd [
	"This method was automatically generated"
	^ (value & ChildEndAndParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndAndParentStart [
	"This method was automatically generated"
	^ (value & ChildEndAndParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndEqualParentEnd [
	"This method was automatically generated"
	^ (value & ChildEndEqualParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndEqualParentStart [
	"This method was automatically generated"
	^ (value & ChildEndEqualParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndGreaterThanParentEnd [
	"This method was automatically generated"
	^ (value & ChildEndGreaterThanParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndGreaterThanParentStart [
	"This method was automatically generated"
	^ (value & ChildEndGreaterThanParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndLessThanParentEnd [
	"This method was automatically generated"
	^ (value & ChildEndLessThanParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildEndLessThanParentStart [
	"This method was automatically generated"
	^ (value & ChildEndLessThanParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartAndParentEnd [
	"This method was automatically generated"
	^ (value & ChildStartAndParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartAndParentStart [
	"This method was automatically generated"
	^ (value & ChildStartAndParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartEqualParentEnd [
	"This method was automatically generated"
	^ (value & ChildStartEqualParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartEqualParentStart [
	"This method was automatically generated"
	^ (value & ChildStartEqualParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartGreaterThanParentEnd [
	"This method was automatically generated"
	^ (value & ChildStartGreaterThanParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartGreaterThanParentStart [
	"This method was automatically generated"
	^ (value & ChildStartGreaterThanParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartLessThanParentEnd [
	"This method was automatically generated"
	^ (value & ChildStartLessThanParentEnd value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasChildStartLessThanParentStart [
	"This method was automatically generated"
	^ (value & ChildStartLessThanParentStart value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasEqual [
	"This method was automatically generated"
	^ (value & Equal value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasGreaterThan [
	"This method was automatically generated"
	^ (value & GreaterThan value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasLessThan [
	"This method was automatically generated"
	^ (value & LessThan value) ~= 0
]

{ #category : #'flags - testing' }
BlBoundsMatcherConstraints >> hasMask [
	"This method was automatically generated"
	^ (value & Mask value) ~= 0
]
