Trait {
	#name : #TBlLayoutChildNode,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - geometry' }
TBlLayoutChildNode >> layoutBounds [
	<return: #BlBounds>

	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> layoutBounds: aBlLayoutBounds [
	self explicitRequirement
]

{ #category : #'api - measure' }
TBlLayoutChildNode >> measure: anExtentSpec [
	self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtentInLocal>

	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> measuredHeight [
	<return: #Number>
	
	^ self measuredExtent height
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> measuredWidth [
	<return: #Number>
	
	^ self measuredExtent width
]

{ #category : #accessing }
TBlLayoutChildNode >> measurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ self explicitRequirement
]

{ #category : #accessing }
TBlLayoutChildNode >> measurement: aBlLayoutNodeMeasurement [
	self explicitRequirement
]

{ #category : #accessing }
TBlLayoutChildNode >> parent [
	<return: #BlLayoutParentNode>

	^ self explicitRequirement
]

{ #category : #accessing }
TBlLayoutChildNode >> parent: aBlLayoutParentNode [
	self explicitRequirement
]

{ #category : #accessing }
TBlLayoutChildNode >> userData [
	<return: #Dictionary>
	
	^ self explicitRequirement
]
