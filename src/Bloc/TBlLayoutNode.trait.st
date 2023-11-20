Trait {
	#name : 'TBlLayoutNode',
	#category : 'Bloc-Layouts-Model',
	#package : 'Bloc',
	#tag : 'Layouts-Model'
}

{ #category : 'accessing' }
TBlLayoutNode >> constraints [
	^ self explicitRequirement
]

{ #category : 'accessing' }
TBlLayoutNode >> constraints: aBlLayoutConstraints [
	self explicitRequirement
]

{ #category : 'api - resizer' }
TBlLayoutNode >> fitContent [
	self
		hFitContent;
		vFitContent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> hExact: aNumber [
	self constraints horizontal exact: aNumber
]

{ #category : 'api - resizer' }
TBlLayoutNode >> hFitContent [
	self constraints horizontal fitContent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> hMatchParent [
	self constraints horizontal matchParent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> horizontalResizer [
	^ self constraints horizontal resizer
]

{ #category : 'api - resizer' }
TBlLayoutNode >> isHorizontalMatchParent [
	^ self horizontalResizer isMatchParent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> isVerticalMatchParent [
	^ self verticalResizer isMatchParent
]

{ #category : 'accessing' }
TBlLayoutNode >> margin [
	^ self constraints margin
]

{ #category : 'api - resizer' }
TBlLayoutNode >> matchParent [
	self
		hMatchParent;
		vMatchParent
]

{ #category : 'accessing' }
TBlLayoutNode >> maxExtent [
	^ self maxWidth @ self maxHeight
]

{ #category : 'accessing' }
TBlLayoutNode >> maxHeight [
	^ self constraints maxHeight
]

{ #category : 'accessing' }
TBlLayoutNode >> maxWidth [
	^ self constraints maxWidth
]

{ #category : 'accessing' }
TBlLayoutNode >> minExtent [
	^ self minWidth @ self minHeight
]

{ #category : 'accessing' }
TBlLayoutNode >> minHeight [
	^ self constraints minHeight
]

{ #category : 'accessing' }
TBlLayoutNode >> minWidth [
	^ self constraints minWidth
]

{ #category : 'accessing' }
TBlLayoutNode >> padding [
	^ self constraints padding
]

{ #category : 'api - resizer' }
TBlLayoutNode >> vExact: aNumber [
	self constraints vertical exact: aNumber
]

{ #category : 'api - resizer' }
TBlLayoutNode >> vFitContent [
	self constraints vertical fitContent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> vMatchParent [
	self constraints vertical matchParent
]

{ #category : 'api - resizer' }
TBlLayoutNode >> verticalResizer [
	^ self constraints vertical resizer
]
