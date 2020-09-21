Trait {
	#name : #TBlLayoutParentNode,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
TBlLayoutParentNode >> children [
	<return: #Collection of: #BlLayoutNode>

	^ self explicitRequirement
]

{ #category : #accessing }
TBlLayoutParentNode >> children: aBlLayoutNodeChildren [
	self explicitRequirement
]

{ #category : #'api - enumerating' }
TBlLayoutParentNode >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ self explicitRequirement
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> extentSpec: aBlExtentMeasurementSpec [
	self explicitRequirement
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> heightSpec [
	^ self extentSpec heightSpec
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> layoutExtent [
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> layoutExtent: aPoint [
	self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> measuredExtent [
	<return: #Point>

	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> measuredExtent: aPoint [
	self explicitRequirement
]

{ #category : #accessing }
TBlLayoutParentNode >> parent [
	^ self explicitRequirement
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> widthSpec [
	^ self extentSpec widthSpec
]
