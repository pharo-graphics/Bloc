Trait {
	#name : #TBlNewLayoutNodeWithConstraints,
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> constraints [
	^ self explicitRequirement
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> constraints: aBlLayoutConstraints [
	self explicitRequirement
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> hMatchParent [
	self constraints horizontal matchParent
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> horizontalResizer [
	^ self constraints horizontal resizer
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> isHorizontalMatchParent [
	^ self horizontalResizer isMatchParent
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> isVerticalMatchParent [
	^ self verticalResizer isMatchParent
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> margin [
	^ self constraints margin
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> matchParent [
	self
		hMatchParent;
		vMatchParent
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> maxExtent [
	^ self maxWidth @ self maxHeight
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> maxHeight [
	^ self constraints maxHeight
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> maxWidth [
	^ self constraints maxWidth
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> minExtent [
	^ self minWidth @ self minHeight
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> minHeight [
	^ self constraints minHeight
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> minWidth [
	^ self constraints minWidth
]

{ #category : #accessing }
TBlNewLayoutNodeWithConstraints >> padding [
	^ self constraints padding
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> vExact: aNumber [
	self constraints vertical exact: aNumber
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> vMatchParent [
	self constraints vertical matchParent
]

{ #category : #'api - resizer' }
TBlNewLayoutNodeWithConstraints >> verticalResizer [
	^ self constraints vertical resizer
]
