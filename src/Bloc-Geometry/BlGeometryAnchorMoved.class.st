"
I am sent when anchor's position changed
"
Class {
	#name : #BlGeometryAnchorMoved,
	#superclass : #BlEvent,
	#instVars : [
		'anchor'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlGeometryAnchorMoved >> anchor [
	<return: #BlGeometryAnchor>

	^ anchor
]

{ #category : #accessing }
BlGeometryAnchorMoved >> anchor: aBlGeometryAnchor [
	anchor := aBlGeometryAnchor
]
