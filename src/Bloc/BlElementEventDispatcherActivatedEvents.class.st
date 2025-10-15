"
I let event dispatcher know which events are enabled and which are not

"
Class {
	#name : #BlElementEventDispatcherActivatedEvents,
	#superclass : #BlBitflags,
	#classVars : [
		'AddedToParent',
		'AddedToSceneGraph',
		'AddedToSuperParent',
		'BackgroundChanged',
		'BorderChanged',
		'ExtentChanged',
		'LayoutChanged',
		'LayoutComputed',
		'MousePickedOutside',
		'PositionChanged',
		'PositionInSpaceChanged',
		'RemovedFromParent',
		'RemovedFromSceneGraph',
		'ScrolledEvent',
		'SelectionAcquired',
		'SelectionLost',
		'TransformationChanged',
		'TransformationInSpaceChanged'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> AddedToParent [
	"This method was automatically generated"
	^ AddedToParent value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> AddedToSceneGraph [
	"This method was automatically generated"
	^ AddedToSceneGraph value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> AddedToSuperParent [
	"This method was automatically generated"
	^ AddedToSuperParent value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> BackgroundChanged [
	"This method was automatically generated"
	^ BackgroundChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> BorderChanged [
	"This method was automatically generated"
	^ BorderChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> ExtentChanged [
	"This method was automatically generated"
	^ ExtentChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> LayoutChanged [
	"This method was automatically generated"
	^ LayoutChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> LayoutComputed [
	"This method was automatically generated"
	^ LayoutComputed value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> MousePickedOutside [
	"This method was automatically generated"
	^ MousePickedOutside value 
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> PositionChanged [
	"This method was automatically generated"
	^ PositionChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> PositionInSpaceChanged [
	"This method was automatically generated"
	^ PositionInSpaceChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> RemovedFromParent [
	"This method was automatically generated"
	^ RemovedFromParent value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> RemovedFromSceneGraph [
	"This method was automatically generated"
	^ RemovedFromSceneGraph value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> ScrolledEvent [
	"This method was automatically generated"
	^ ScrolledEvent value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> SelectionAcquired [
	"This method was automatically generated"
	^ SelectionAcquired value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> SelectionLost [
	"This method was automatically generated"
	^ SelectionLost value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> TransformationChanged [
	"This method was automatically generated"
	^ TransformationChanged value
]

{ #category : #'accessing - flags' }
BlElementEventDispatcherActivatedEvents class >> TransformationInSpaceChanged [
	"This method was automatically generated"
	^ TransformationInSpaceChanged value
]

{ #category : #'flags declaration' }
BlElementEventDispatcherActivatedEvents class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	
	^ {
		#AddedToParent.
		#AddedToSceneGraph.
		#AddedToSuperParent.
		#BackgroundChanged.
		#BorderChanged.
		#ExtentChanged.
		#LayoutChanged.
		#LayoutComputed.
		#PositionChanged.
		#PositionInSpaceChanged.
		#RemovedFromParent.
		#RemovedFromSceneGraph.
		#ScrolledEvent.
		#SelectionAcquired.
		#SelectionLost.
		#TransformationChanged.
		#TransformationInSpaceChanged.
		#MousePickedOutside.
	}


]

{ #category : #'class initialization' }
BlElementEventDispatcherActivatedEvents class >> initialize [
	"this method is needed else the information is not created. 
	This is the sign of a bad design.
	"
	super initialize.
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addAddedToParent [
	"This method was automatically generated"
	value := value | AddedToParent value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addAddedToSceneGraph [
	"This method was automatically generated"
	value := value | AddedToSceneGraph value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addAddedToSuperParent [
	"This method was automatically generated"
	value := value | AddedToSuperParent value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addBackgroundChanged [
	"This method was automatically generated"
	value := value | BackgroundChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addBorderChanged [
	"This method was automatically generated"
	value := value | BorderChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addExtentChanged [
	"This method was automatically generated"
	value := value | ExtentChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addLayoutChanged [
	"This method was automatically generated"
	value := value | LayoutChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addLayoutComputed [
	"This method was automatically generated"
	value := value | LayoutComputed value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addMousePickedOutside [
	"This method was automatically generated"
	value := value | MousePickedOutside value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addPositionChanged [
	"This method was automatically generated"
	value := value | PositionChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addPositionInSpaceChanged [
	"This method was automatically generated"
	value := value | PositionInSpaceChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addRemovedFromParent [
	"This method was automatically generated"
	value := value | RemovedFromParent value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addRemovedFromSceneGraph [
	"This method was automatically generated"
	value := value | RemovedFromSceneGraph value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addScrolledEvent [
	"This method was automatically generated"
	value := value | ScrolledEvent value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addSelectionAcquired [
	"This method was automatically generated"
	value := value | SelectionAcquired value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addSelectionLost [
	"This method was automatically generated"
	value := value | SelectionLost value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addTransformationChanged [
	"This method was automatically generated"
	value := value | TransformationChanged value
]

{ #category : #'flags - add' }
BlElementEventDispatcherActivatedEvents >> addTransformationInSpaceChanged [
	"This method was automatically generated"
	value := value | TransformationInSpaceChanged value
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearAddedToParent [
	"This method was automatically generated"
	value := value & (AddedToParent value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearAddedToSceneGraph [
	"This method was automatically generated"
	value := value & (AddedToSceneGraph value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearAddedToSuperParent [
	"This method was automatically generated"
	value := value & (AddedToSuperParent value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearBackgroundChanged [
	"This method was automatically generated"
	value := value & (BackgroundChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearBorderChanged [
	"This method was automatically generated"
	value := value & (BorderChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearExtentChanged [
	"This method was automatically generated"
	value := value & (ExtentChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearLayoutChanged [
	"This method was automatically generated"
	value := value & (LayoutChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearLayoutComputed [
	"This method was automatically generated"
	value := value & (LayoutComputed value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearMousePickedOutside [
	"This method was automatically generated"
	value := value & (MousePickedOutside value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearPositionChanged [
	"This method was automatically generated"
	value := value & (PositionChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearPositionInSpaceChanged [
	"This method was automatically generated"
	value := value & (PositionInSpaceChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearRemovedFromParent [
	"This method was automatically generated"
	value := value & (RemovedFromParent value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearRemovedFromSceneGraph [
	"This method was automatically generated"
	value := value & (RemovedFromSceneGraph value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearScrolledEvent [
	"This method was automatically generated"
	value := value & (ScrolledEvent value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearSelectionAcquired [
	"This method was automatically generated"
	value := value & (SelectionAcquired value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearSelectionLost [
	"This method was automatically generated"
	value := value & (SelectionLost value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearTransformationChanged [
	"This method was automatically generated"
	value := value & (TransformationChanged value bitInvert)
]

{ #category : #'flags - clear' }
BlElementEventDispatcherActivatedEvents >> clearTransformationInSpaceChanged [
	"This method was automatically generated"
	value := value & (TransformationInSpaceChanged value bitInvert)
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasAddedToParent [
	"This method was automatically generated"
	^ (value & AddedToParent value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasAddedToSceneGraph [
	"This method was automatically generated"
	^ (value & AddedToSceneGraph value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasAddedToSuperParent [
	"This method was automatically generated"
	^ (value & AddedToSuperParent value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasBackgroundChanged [
	"This method was automatically generated"
	^ (value & BackgroundChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasBorderChanged [
	"This method was automatically generated"
	^ (value & BorderChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasExtentChanged [
	"This method was automatically generated"
	^ (value & ExtentChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasLayoutChanged [
	"This method was automatically generated"
	^ (value & LayoutChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasLayoutComputed [
	"This method was automatically generated"
	^ (value & LayoutComputed value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasMousePickedOutside [
	"This method was automatically generated"
	^ (value & MousePickedOutside value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasPositionChanged [
	"This method was automatically generated"
	^ (value & PositionChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasPositionInSpaceChanged [
	"This method was automatically generated"
	^ (value & PositionInSpaceChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasRemovedFromParent [
	"This method was automatically generated"
	^ (value & RemovedFromParent value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasRemovedFromSceneGraph [
	"This method was automatically generated"
	^ (value & RemovedFromSceneGraph value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasScrolledEvent [
	"This method was automatically generated"
	^ (value & ScrolledEvent value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasSelectionAcquired [
	"This method was automatically generated"
	^ (value & SelectionAcquired value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasSelectionLost [
	"This method was automatically generated"
	^ (value & SelectionLost value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasTransformationChanged [
	"This method was automatically generated"
	^ (value & TransformationChanged value) ~= 0
]

{ #category : #'flags - testing' }
BlElementEventDispatcherActivatedEvents >> hasTransformationInSpaceChanged [
	"This method was automatically generated"
	^ (value & TransformationInSpaceChanged value) ~= 0
]
