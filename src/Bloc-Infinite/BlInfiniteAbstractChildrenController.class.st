"
I define an interface between child manager and infinite element.
Child manager communicates with infinite element  only using my interface
"
Class {
	#name : #BlInfiniteAbstractChildrenController,
	#superclass : #Object,
	#category : 'Bloc-Infinite-Children'
}

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> addChild: anElement at: anIndex [
	"Add anElement as direct child to infinite element at anIndex.
	anElement must not be nil
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> attachChild: anElement at: anIndex [
	"Adds child to infinite element without redraw or layout requests.
	anElement must not be nil.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> childAt: anIndex [
	"Return a child that is at anIndex in children collection
	of infinite element or nil if anIndex is out of range.
	anIndex must not be nil"
	<return: #BlElement or: nil>
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> childIndexOf: aChildElement [
	"Return an index of aChildElement within children collection
	of infinite element or 0 if child is not a direct child of
	infinite element.
	aChildElement must not be nil.
	aChildElement must not be nil"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> childrenCount [
	"Return amount of children in infinite element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> detachChildAt: anIndex [
	"Remove a child from infinite element at anIndex without
	redraw and layout requests.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> elementHolderOf: anElement [
	"Return an element holder of the child element.
	ElementHolder can not be nil"
	<return: #BlInfiniteHolder>

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> onEnteredHiddenState: aChildElement [
	"Notify infinite element that child element is now hidden.
	aChildElement must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> onLeftHiddenState: aChildElement [
	"Notify infinite element that child element is not hidden anymore.
	aChildElement must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> removeAllChildren [
	"Remove all direct children from infinite element"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
BlInfiniteAbstractChildrenController >> removeChildAt: anIndex [
	"Remove a child at anIndex from infinite element.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]
