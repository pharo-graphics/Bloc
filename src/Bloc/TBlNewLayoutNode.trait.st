Trait {
	#name : 'TBlNewLayoutNode',
	#category : 'Bloc-Layouts-Model-New'
}

{ #category : 'api - geometry' }
TBlNewLayoutNode >> bottom [
	^ self position y + self height
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> bounds [
	<return: #BlBounds>
	
	^ BlBounds
		origin: self position
		extent: self extent
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ self explicitRequirement
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> height [
	<return: #Number>
	
	^ self extent y
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> layoutBounds [
	<return: #BlBounds>

	^ self explicitRequirement
]

{ #category : 'api - measure' }
TBlNewLayoutNode >> measure: anExtentSpec [
	self explicitRequirement
]

{ #category : 'accessing' }
TBlNewLayoutNode >> measurement: aBlLayoutNodeMeasurement [
	self explicitRequirement
]

{ #category : 'accessing' }
TBlNewLayoutNode >> parent [
	<return: #BlLayoutParentNode>

	^ self explicitRequirement
]

{ #category : 'accessing' }
TBlNewLayoutNode >> parent: aBlLayoutParentNode [
	self explicitRequirement
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> perimeter [
	^ (self width + self height) * 2
]

{ #category : 'api - actions' }
TBlNewLayoutNode >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ self explicitRequirement
]

{ #category : 'api - actions' }
TBlNewLayoutNode >> popActions [
	<return: #Collection of: #BlLayoutNodeElementAction>
	
	^ Array streamContents: [ :aStream |
		| eachAction |
		[ (eachAction := self popAction) notNil ] whileTrue: [ aStream nextPut: eachAction ] ]
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ self explicitRequirement
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	self explicitRequirement
]

{ #category : 'accessing' }
TBlNewLayoutNode >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ self explicitRequirement
]

{ #category : 'api - actions' }
TBlNewLayoutNode >> pushAction: aBlLayoutNodeElementAction [
	self explicitRequirement
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> right [
	^ self position x + self width
]

{ #category : 'accessing' }
TBlNewLayoutNode >> userData [
	<return: #Dictionary>
	
	^ self explicitRequirement
]

{ #category : 'api - geometry' }
TBlNewLayoutNode >> width [
	<return: #Number>
	
	^ self extent x
]
