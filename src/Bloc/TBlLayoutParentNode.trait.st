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

{ #category : #'api - geometry' }
TBlLayoutParentNode >> extent [
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> extent: aPoint [
	self explicitRequirement
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

{ #category : #'api - geometry' }
TBlLayoutParentNode >> height [
	^ self extent y
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> heightSpec [
	^ self extentSpec heightSpec
]

{ #category : #accessing }
TBlLayoutParentNode >> parent [
	^ self explicitRequirement
]

{ #category : #accessing }
TBlLayoutParentNode >> position [
	^ self explicitRequirement
]

{ #category : #accessing }
TBlLayoutParentNode >> position: aPoint [
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutParentNode >> width [
	^ self extent x
]

{ #category : #'api - extent spec' }
TBlLayoutParentNode >> widthSpec [
	^ self extentSpec widthSpec
]
