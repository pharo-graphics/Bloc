Class {
	#name : #BlLayoutNonLeafParentNode,
	#superclass : #BlAbstractLayoutParentNode,
	#instVars : [
		'parentNode'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutNonLeafParentNode >> children [

	^ parentNode children
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> constraints [

	^ parentNode constraints
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> constraints: aBlLayoutConstraints [

	parentNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutNonLeafParentNode >> extent [

	^ parentNode extent
]

{ #category : #'api - geometry' }
BlLayoutNonLeafParentNode >> extent: aPoint [

	parentNode extent: aPoint
]

{ #category : #'api - extent spec' }
BlLayoutNonLeafParentNode >> extentSpec [

	^ parentNode extentSpec
]

{ #category : #'api - extent spec' }
BlLayoutNonLeafParentNode >> extentSpec: aBlExtentMeasurementSpec [

	parentNode extentSpec: aBlExtentMeasurementSpec
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> parent [

	^ parentNode parent
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> parentNode [

	^ parentNode
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> parentNode: aNode [

	parentNode := aNode
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> position [

	^ parentNode position
]

{ #category : #accessing }
BlLayoutNonLeafParentNode >> position: aPoint [

	parentNode position: aPoint
]
