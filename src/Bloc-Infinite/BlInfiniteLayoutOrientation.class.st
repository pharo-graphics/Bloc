Class {
	#name : #BlInfiniteLayoutOrientation,
	#superclass : #Object,
	#instVars : [
		'lastTotalSpace',
		'layout'
	],
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedEnd: anElement [
	"Return the end of the element including its decoration and margin"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedEndInParent: anElement [
	"Return the end of the Element after its matrix transformations are applied to its layout position.
	I am useful when trying to detect the visible edge of an element.
	Note: It include the decorations but do not include the margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedMeasurement: anElement [
	"Return the space occupied by an element in the current orientation including decorations and margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedMeasurementInOther: anElement [
	"Return the space occupied by an element in the perpendicular orientation including decorations and margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedStart: anElement [
	"Return the start of the element including its decoration and margin"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> decoratedStartInParent: anElement [
	"Return the start of the Element after its matrix transformations are applied to its layout position.
	I am useful when trying to detect the visible edge of an element.
	Note: It include the decorations but do not include the margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> end [
	"Return the end position of the layout without taking padding into account"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> endWithPadding [
	"Return the end position of the layout after the end padding is removed"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlInfiniteLayoutOrientation >> isHorizontal [
	^ self subclassResponsibility
]

{ #category : #testing }
BlInfiniteLayoutOrientation >> isVertical [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlInfiniteLayoutOrientation >> layout [
	^ layout
]

{ #category : #accessing }
BlInfiniteLayoutOrientation >> layout: aLayout [
	layout := aLayout
]

{ #category : #layout }
BlInfiniteLayoutOrientation >> layoutCompleted [
	"I record information like layout bounds that might be useful in the next layout calculations"
	lastTotalSpace := self totalSpace
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> maximumSpace [
	"Return a number representing the maximum space."

	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> measurementSpec [
	"Return the MeasurementSpec for the current orientation from the InfiniteLayout"
	<return: #BlMeasurementSpec>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> measurementSpecInOther [
	"Return the MeasurementSpec for the perpendicular orientation from the InfiniteLayout"
	<return: #BlMeasurementSpec>

	^ self subclassResponsibility
]

{ #category : #'mouse handlers' }
BlInfiniteLayoutOrientation >> mouseWheelEvent: anEvent [
	"Scroll an infinite element to a direction indicated by the event.
	The ${method:BlInfiniteMouseScrollOrientationLimitedListener>>#mouseWheelEvent:}$
	dispatches mouse wheel event processing to layouts. Layouts decides whether and how to scroll items.
	See ${method:BlInfiniteLinearLayout>>#mouseWheelEvent:}$"
	self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> moveChild: anElement by: aNumber [
	"Move a child element by offsetting its position by the given amount"
	
	self subclassResponsibility
]

{ #category : #'children - geometry' }
BlInfiniteLayoutOrientation >> moveChildrenBy: aNumber [
	"Move all children by offsetting their positions by the given amount"
	
	self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> paddingEnd [
	"Returns the padding at the end of the layout.
	For horizontal orientation, this is the right padding and for vertical, this is the bottom padding.
	Note: I do not check whether the layout is RTL or not"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> paddingStart [
	"Returns the padding at the beginning of the layout.
	For horizontal orientation, this is the left padding and for vertical, this is the top padding.
	Note: I do not check whether the layout is RTL or not"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #invalidation }
BlInfiniteLayoutOrientation >> reset [
	lastTotalSpace := nil.
	layout := nil
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> startWithPadding [
	"Return the start position of the layout after the start padding is added"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> totalSpace [
	"Returns the total space to layout"

	^ self endWithPadding - self startWithPadding
]

{ #category : #geometry }
BlInfiniteLayoutOrientation >> totalSpaceChange [
	"Return the layout space change between the previous layout pass and current layout pass"
	<return: #Number>
	
	^ lastTotalSpace
		ifNil: [ 0 ]
		ifNotNil: [ :aNumber | self totalSpace - aNumber ]
]
