"
I am a special layout that uses measured positions of children to determine parent's extent.

I should be considered to be a root of graph or visualisation layouts. For that purpose override measurePositions: with:
"
Class {
	#name : #BlFitLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #measure }
BlFitLayout >> boundingBox: anElement [
	<return: #Rectangle>
	| aBoundingBox |

	anElement children isEmpty
		ifTrue: [ ^ BlBounds new asRectangle ].

	aBoundingBox := nil.
	self
		layeredChildren: anElement
		do: [ :aChild |
			aBoundingBox
				ifNil: [ aBoundingBox := BlBounds fromRectangle: aChild measuredBounds bounds ]
				ifNotNil: [ aBoundingBox merge: aChild measuredBounds bounds ] ].

	^ aBoundingBox expanded asRectangle
]

{ #category : #layout }
BlFitLayout >> fit: anElement with: anExtentSpec [
	| boundingBox width height |

	boundingBox := self boundingBox: anElement.

	width := boundingBox width + anElement padding width.
	height := boundingBox height + anElement padding height.

	anElement measuredExtent: (anExtentSpec sizeFor: width @ height)
]

{ #category : #layout }
BlFitLayout >> layout: anElement in: aRectangle [
	| aDelta |
	
	aDelta := self normalizedDelta: anElement in: aRectangle.

	self layoutIgnored: anElement.
	self
		layeredChildren: anElement
		do: [ :aChild | aChild applyLayoutIn: (aChild measuredPosition + aDelta extent: aChild measuredExtent) ]
]

{ #category : #measure }
BlFitLayout >> measure: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"
	
	self subclassResponsibility
]

{ #category : #measure }
BlFitLayout >> measure: anElement with: anExtentSpec [
	
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ].

	self measurePositions: anElement with: anExtentSpec.
	
	self fit: anElement with: anExtentSpec.
	
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #measure }
BlFitLayout >> measurePositions: anElement with: anExtentSpec [
	| aParentNode |

	aParentNode := (BlLayoutParentNode alreadyMeasured: anElement) extentSpec: anExtentSpec.

	self measure: aParentNode.
	
	aParentNode children do: [ :eachChildNode |
		eachChildNode element measuredBounds position: eachChildNode measurement position.
		eachChildNode element measuredBounds extent: eachChildNode measurement extent ].

	anElement userData at: #layoutNode put: aParentNode
]

{ #category : #measure }
BlFitLayout >> normalizedDelta: anElement in: aRectangle [
	| boundingBox delta |

	boundingBox := self boundingBox: anElement.
	delta := ((aRectangle extent / 2.0) - boundingBox center).

	^ delta
]
