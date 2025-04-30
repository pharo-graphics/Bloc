Class {
	#name : #BlLayoutParentNodeWithTransformation,
	#superclass : #BlLayoutNonLeafParentNode,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> children: aBlLayoutNodeChildren [

	parentNode children: aBlLayoutNodeChildren
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithTransformation >> extent: aPoint [

	super extent: aPoint.

	transformation boundingRectangle:
		(BlBounds origin: self position extent: aPoint)
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> position: aPoint [

	super position: aPoint.
	
	transformation boundingRectangle:
		(Rectangle origin: aPoint extent: self extent)
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformation [

	^ transformation
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformation: aBlElementTransformation [

	transformation :=
		aBlElementTransformation asCachedTransformationIn:
			(Rectangle
				origin: self position
				extent: self extent)
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformationDo: aBlock [

	aBlock value: transformation
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithTransformation >> withTransformation: aBlElementTransformation [

	^ self class new
		  parentNode: parentNode;
		  transformation: aBlElementTransformation;
		  yourself
]
