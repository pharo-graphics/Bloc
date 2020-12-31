Class {
	#name : #BlNewLayoutNodeDecoration,
	#superclass : #Object,
	#type : #variable,
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> getExtentOf: aLayoutNode [
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> getLayoutBoundsOf: aLayoutNode [
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> getPositionOf: aLayoutNode [
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> measure: anExtentSpecOrBlock of: aLayoutNode [	
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode [
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> setPosition: aPoint of: aLayoutNode [
	self subclassResponsibility
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecoration >> transformationDo: aBlock [
	self subclassResponsibility
]

{ #category : #converting }
BlNewLayoutNodeDecoration >> withElement: anElement [
	^ BlNewLayoutNodeDecorationWithElement new
		element: anElement;
		decoration: self
]
