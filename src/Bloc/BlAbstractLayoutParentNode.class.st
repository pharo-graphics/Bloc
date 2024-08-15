Class {
	#name : #BlAbstractLayoutParentNode,
	#superclass : #BlLayoutNode,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlAbstractLayoutParentNode >> children [
	"Answer a collection of `BlLayoutNode`"

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutParentNode >> children: aBlLayoutNodeChildren [

	self subclassResponsibility
]

{ #category : #'api - enumerating' }
BlAbstractLayoutParentNode >> childrenDo: aBlock [

	self children do: aBlock
]

{ #category : #'api - geometry' }
BlAbstractLayoutParentNode >> extent [

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutParentNode >> extent: aPoint [

	self subclassResponsibility
]

{ #category : #'api - extent spec' }
BlAbstractLayoutParentNode >> extentSpec [

	^ self subclassResponsibility
]

{ #category : #'api - extent spec' }
BlAbstractLayoutParentNode >> extentSpec: aBlExtentMeasurementSpec [

	self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutParentNode >> height [

	^ self extent y
]

{ #category : #'api - extent spec' }
BlAbstractLayoutParentNode >> heightSpec [

	^ self extentSpec heightSpec
]

{ #category : #accessing }
BlAbstractLayoutParentNode >> parent [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutParentNode >> position [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutParentNode >> position: aPoint [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutParentNode >> transformationDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutParentNode >> width [

	^ self extent x
]

{ #category : #'api - extent spec' }
BlAbstractLayoutParentNode >> widthSpec [

	^ self extentSpec widthSpec
]

{ #category : #'api - converting' }
BlAbstractLayoutParentNode >> withFilter: aSelectBlock [
	^ BlLayoutParentNodeWithFilter new
		parentNode: self;
		filterBlock: aSelectBlock;
		children: (self children select: aSelectBlock)
]
