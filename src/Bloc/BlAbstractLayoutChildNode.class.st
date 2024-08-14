Class {
	#name : #BlAbstractLayoutChildNode,
	#superclass : #BlLayoutNode,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> bottom [

	^ self position y + self height
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> bounds [

	^ BlBounds origin: self position extent: self extent
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> extent [
	"Return a `Point` that represents the size of the node in the parent coordinate system"

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> height [

	^ self extent y
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> layoutBounds [
	"Answer a `BlBounds`"

	^ self subclassResponsibility
]

{ #category : #'api - measure' }
BlAbstractLayoutChildNode >> measure: anExtentSpec [

	self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutChildNode >> measurement: aBlLayoutNodeMeasurement [

	self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutChildNode >> parent [
	"Answer a `BlLayoutParentNode` that represents my parent node."

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutChildNode >> parent: aBlLayoutParentNode [

	self subclassResponsibility
]

{ #category : #'api - actions' }
BlAbstractLayoutChildNode >> popAction [
	"Answer a `BlLayoutNodeElementAction` or nil"

	^ self subclassResponsibility
]

{ #category : #'api - actions' }
BlAbstractLayoutChildNode >> popActions [
	<return: #Collection of: #BlLayoutNodeElementAction>
	
	^ Array streamContents: [ :aStream |
		| eachAction |
		[ (eachAction := self popAction) notNil ] whileTrue: [ aStream nextPut: eachAction ] ]
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> position [
	"Return a `Point` that represents the position of the top left corner
	of this node in the parent coordinate system."
	
	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	
	self subclassResponsibility
]

{ #category : #accessing }
BlAbstractLayoutChildNode >> privateMeasurement [
	"Answer a `BlLayoutNodeMeasurement`"
	
	^ self subclassResponsibility
]

{ #category : #'api - actions' }
BlAbstractLayoutChildNode >> pushAction: aBlLayoutNodeElementAction [

	self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> right [

	^ self position x + self width
]

{ #category : #accessing }
BlAbstractLayoutChildNode >> userData [
	"Answer a `Dictionary` that is available to access and store values."
	
	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlAbstractLayoutChildNode >> width [

	^ self extent x
]

{ #category : #converting }
BlAbstractLayoutChildNode >> withEdges: aCollectionOfLayoutEdges [

	^ BlLayoutChildNodeWithEdges new
		  childNode: self;
		  connectedEdges: aCollectionOfLayoutEdges;
		  yourself
]
