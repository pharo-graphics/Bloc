Trait {
	#name : #TBlLayoutChildNode,
	#category : 'Bloc-Layouts-Model'
}

{ #category : #'api - geometry' }
TBlLayoutChildNode >> bottom [
	^ self position y + self height
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> bounds [
	<return: #BlBounds>
	
	^ BlBounds
		origin: self position
		extent: self extent
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> height [
	<return: #Number>
	
	^ self extent y
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> layoutBounds [
	<return: #BlBounds>

	^ self explicitRequirement
]

{ #category : #'api - measure' }
TBlLayoutChildNode >> measure: anExtentSpec [
	self explicitRequirement
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

{ #category : #'api - geometry' }
TBlLayoutChildNode >> perimeter [
	^ (self width + self height) * 2
]

{ #category : #'api - actions' }
TBlLayoutChildNode >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ self explicitRequirement
]

{ #category : #'api - actions' }
TBlLayoutChildNode >> popActions [
	<return: #Collection of: #BlLayoutNodeElementAction>
	
	^ Array streamContents: [ :aStream |
		| eachAction |
		[ (eachAction := self popAction) notNil ] whileTrue: [ aStream nextPut: eachAction ] ]
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	self explicitRequirement
]

{ #category : #accessing }
TBlLayoutChildNode >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ self explicitRequirement
]

{ #category : #'api - actions' }
TBlLayoutChildNode >> pushAction: aBlLayoutNodeElementAction [
	self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> right [
	^ self position x + self width
]

{ #category : #accessing }
TBlLayoutChildNode >> userData [
	<return: #Dictionary>
	
	^ self explicitRequirement
]

{ #category : #'api - geometry' }
TBlLayoutChildNode >> width [
	<return: #Number>
	
	^ self extent x
]
