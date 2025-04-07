"
# Layout node
Is a node that is laied out by `BlLayout`

"
Class {
	#name : #BlLayoutNode,
	#superclass : #Object,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutNode >> constraints [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlLayoutNode >> constraints: aBlLayoutConstraints [

	self subclassResponsibility
]

{ #category : #'api - resizer' }
BlLayoutNode >> fitContent [

	self
		hFitContent;
		vFitContent
]

{ #category : #'api - resizer' }
BlLayoutNode >> hExact: aNumber [

	self constraints horizontal exact: aNumber
]

{ #category : #'api - resizer' }
BlLayoutNode >> hFitContent [

	self constraints horizontal fitContent
]

{ #category : #'api - resizer' }
BlLayoutNode >> hMatchParent [

	self constraints horizontal matchParent
]

{ #category : #'api - resizer' }
BlLayoutNode >> horizontalResizer [

	^ self constraints horizontal resizer
]

{ #category : #'api - resizer' }
BlLayoutNode >> isHorizontalMatchParent [

	^ self horizontalResizer isMatchParent
]

{ #category : #'api - resizer' }
BlLayoutNode >> isVerticalMatchParent [

	^ self verticalResizer isMatchParent
]

{ #category : #accessing }
BlLayoutNode >> margin [

	^ self constraints margin
]

{ #category : #'api - resizer' }
BlLayoutNode >> matchParent [

	self
		hMatchParent;
		vMatchParent
]

{ #category : #accessing }
BlLayoutNode >> maxExtent [

	^ self maxWidth @ self maxHeight
]

{ #category : #accessing }
BlLayoutNode >> maxHeight [

	^ self constraints maxHeight
]

{ #category : #accessing }
BlLayoutNode >> maxWidth [

	^ self constraints maxWidth
]

{ #category : #accessing }
BlLayoutNode >> minExtent [

	^ self minWidth @ self minHeight
]

{ #category : #accessing }
BlLayoutNode >> minHeight [

	^ self constraints minHeight
]

{ #category : #accessing }
BlLayoutNode >> minWidth [

	^ self constraints minWidth
]

{ #category : #accessing }
BlLayoutNode >> padding [

	^ self constraints padding
]

{ #category : #'api - resizer' }
BlLayoutNode >> vExact: aNumber [

	self constraints vertical exact: aNumber
]

{ #category : #'api - resizer' }
BlLayoutNode >> vFitContent [

	self constraints vertical fitContent
]

{ #category : #'api - resizer' }
BlLayoutNode >> vMatchParent [

	self constraints vertical matchParent
]

{ #category : #'api - resizer' }
BlLayoutNode >> verticalResizer [

	^ self constraints vertical resizer
]
