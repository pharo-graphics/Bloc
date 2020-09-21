Class {
	#name : #BlLayoutParentNodeWithEdges,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutParentNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutParentNode classTrait',
	#instVars : [
		'parentNode',
		'children'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> children [
	<return: #Collection of: #BlLayoutNode>

	^ children
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> children: aBlLayoutNodeChildren [
	children := aBlLayoutNodeChildren as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> constraints [
	^ parentNode constraints
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> constraints: aBlLayoutConstraints [
	parentNode constraints: aBlLayoutConstraints
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithEdges >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ parentNode extentSpec
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithEdges >> extentSpec: aBlExtentMeasurementSpec [
	parentNode extentSpec: aBlExtentMeasurementSpec
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithEdges >> layoutExtent [
	^ parentNode layoutExtent
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithEdges >> layoutExtent: aPoint [
	parentNode layoutExtent: aPoint
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithEdges >> measuredExtent [
	<return: #Point>

	^ parentNode measuredExtent
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithEdges >> measuredExtent: aPoint [
	parentNode measuredExtent: aPoint
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> parent [
	^ parentNode parent
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> parentNode [
	^ parentNode
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithEdges >> withFilter: aSelectBlock [
	^ BlLayoutParentNodeWithFilter new
		parentNode: self;
		filterBlock: aSelectBlock;
		children: (self children select: aSelectBlock)
]
