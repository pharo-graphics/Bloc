Class {
	#name : #BlNewLayoutNodeWrapperDecoration,
	#superclass : #BlNewLayoutNodeDecoration,
	#type : #variable,
	#instVars : [
		'decoration'
	],
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #accessing }
BlNewLayoutNodeWrapperDecoration >> decoration [
	^ decoration
]

{ #category : #accessing }
BlNewLayoutNodeWrapperDecoration >> decoration: anObject [
	decoration := anObject
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> getExtentOf: aLayoutNode [
	^ decoration getExtentOf: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> getLayoutBoundsOf: aLayoutNode [
	<return: #BlBounds>

	^ decoration getLayoutBoundsOf: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> getPositionOf: aLayoutNode [
	^ decoration getPositionOf: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> measure: anExtentSpecOrBlock of: aLayoutNode [	
	decoration measure: anExtentSpecOrBlock of: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode [
	decoration setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> setPosition: aPoint of: aLayoutNode [
	decoration setPosition: aPoint of: aLayoutNode
]

{ #category : #'api - decoration' }
BlNewLayoutNodeWrapperDecoration >> transformationDo: aBlock [
	decoration transformationDo: aBlock
]
