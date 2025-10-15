Class {
	#name : #BlElementFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'NeedsLayout',
		'NeedsPaint',
		'ShouldChildrenHandleMouseEvents',
		'ShouldHandleMouseEvents',
		'ShouldIgnoreLayoutRequests',
		'WaitingLayout'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'accessing - flags' }
BlElementFlags class >> NeedsLayout [
	"This method was automatically generated"
	^ NeedsLayout value
]

{ #category : #'accessing - flags' }
BlElementFlags class >> NeedsPaint [
	"This method was automatically generated"
	^ NeedsPaint value
]

{ #category : #'accessing - flags' }
BlElementFlags class >> ShouldChildrenHandleMouseEvents [
	"This method was automatically generated"
	^ ShouldChildrenHandleMouseEvents value
]

{ #category : #'accessing - flags' }
BlElementFlags class >> ShouldHandleMouseEvents [
	"This method was automatically generated"
	^ ShouldHandleMouseEvents value
]

{ #category : #'accessing - flags' }
BlElementFlags class >> ShouldIgnoreLayoutRequests [
	"This method was automatically generated"
	^ ShouldIgnoreLayoutRequests value
]

{ #category : #'accessing - flags' }
BlElementFlags class >> WaitingLayout [
	"This method was automatically generated"
	^ WaitingLayout value
]

{ #category : #'flags declaration' }
BlElementFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	
	^ {
		#ShouldHandleMouseEvents.
		#ShouldChildrenHandleMouseEvents.
		#NeedsPaint.
		#NeedsLayout.
		#WaitingLayout.
		#ShouldIgnoreLayoutRequests.
	}
]

{ #category : #'class initialization' }
BlElementFlags class >> initialize [
	"this method is needed else the information is not created. 
	This is the sign of a bad design.
	"
	super initialize.
]

{ #category : #'flags - add' }
BlElementFlags >> addNeedsLayout [
	"This method was automatically generated"
	value := value | NeedsLayout value
]

{ #category : #'flags - add' }
BlElementFlags >> addNeedsPaint [
	"This method was automatically generated"
	value := value | NeedsPaint value
]

{ #category : #'flags - add' }
BlElementFlags >> addShouldChildrenHandleMouseEvents [
	"This method was automatically generated"
	value := value | ShouldChildrenHandleMouseEvents value
]

{ #category : #'flags - add' }
BlElementFlags >> addShouldHandleMouseEvents [
	"This method was automatically generated"
	value := value | ShouldHandleMouseEvents value
]

{ #category : #'flags - add' }
BlElementFlags >> addShouldIgnoreLayoutRequests [
	"This method was automatically generated"
	value := value | ShouldIgnoreLayoutRequests value
]

{ #category : #'flags - add' }
BlElementFlags >> addWaitingLayout [
	"This method was automatically generated"
	value := value | WaitingLayout value
]

{ #category : #'flags - clear' }
BlElementFlags >> clearNeedsLayout [
	"This method was automatically generated"
	value := value & (NeedsLayout value bitInvert)
]

{ #category : #'flags - clear' }
BlElementFlags >> clearNeedsPaint [
	"This method was automatically generated"
	value := value & (NeedsPaint value bitInvert)
]

{ #category : #'flags - clear' }
BlElementFlags >> clearShouldChildrenHandleMouseEvents [
	"This method was automatically generated"
	value := value & (ShouldChildrenHandleMouseEvents value bitInvert)
]

{ #category : #'flags - clear' }
BlElementFlags >> clearShouldHandleMouseEvents [
	"This method was automatically generated"
	value := value & (ShouldHandleMouseEvents value bitInvert)
]

{ #category : #'flags - clear' }
BlElementFlags >> clearShouldIgnoreLayoutRequests [
	"This method was automatically generated"
	value := value & (ShouldIgnoreLayoutRequests value bitInvert)
]

{ #category : #'flags - clear' }
BlElementFlags >> clearWaitingLayout [
	"This method was automatically generated"
	value := value & (WaitingLayout value bitInvert)
]

{ #category : #'flags - testing' }
BlElementFlags >> hasNeedsLayout [
	"This method was automatically generated"
	^ (value & NeedsLayout value) ~= 0
]

{ #category : #'flags - testing' }
BlElementFlags >> hasNeedsPaint [
	"This method was automatically generated"
	^ (value & NeedsPaint value) ~= 0
]

{ #category : #'flags - testing' }
BlElementFlags >> hasShouldChildrenHandleMouseEvents [
	"This method was automatically generated"
	^ (value & ShouldChildrenHandleMouseEvents value) ~= 0
]

{ #category : #'flags - testing' }
BlElementFlags >> hasShouldHandleMouseEvents [
	"This method was automatically generated"
	^ (value & ShouldHandleMouseEvents value) ~= 0
]

{ #category : #'flags - testing' }
BlElementFlags >> hasShouldIgnoreLayoutRequests [
	"This method was automatically generated"
	^ (value & ShouldIgnoreLayoutRequests value) ~= 0
]

{ #category : #'flags - testing' }
BlElementFlags >> hasWaitingLayout [
	"This method was automatically generated"
	^ (value & WaitingLayout value) ~= 0
]
