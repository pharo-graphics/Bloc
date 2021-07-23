Trait {
	#name : 'TBlNewLayoutCompositeNode',
	#category : 'Bloc-Layouts-Model-New'
}

{ #category : 'api - extent spec' }
TBlNewLayoutCompositeNode >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ self explicitRequirement
]

{ #category : 'api - extent spec' }
TBlNewLayoutCompositeNode >> extentSpec: aBlExtentMeasurementSpec [
	self explicitRequirement
]

{ #category : 'api - extent spec' }
TBlNewLayoutCompositeNode >> heightSpec [
	^ self extentSpec heightSpec
]

{ #category : 'api - extent spec' }
TBlNewLayoutCompositeNode >> widthSpec [
	^ self extentSpec widthSpec
]
