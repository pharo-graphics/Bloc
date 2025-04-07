Class {
	#name : #BlMorphExtentChangedAnnouncement,
	#superclass : #MorphAnnouncement,
	#instVars : [
		'oldExtent',
		'newExtent'
	],
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #accessing }
BlMorphExtentChangedAnnouncement >> newExtent [

	^ newExtent
]

{ #category : #accessing }
BlMorphExtentChangedAnnouncement >> newExtent: aPoint [

	newExtent := aPoint
]

{ #category : #accessing }
BlMorphExtentChangedAnnouncement >> oldExtent [

	^ oldExtent
]

{ #category : #accessing }
BlMorphExtentChangedAnnouncement >> oldExtent: aPoint [

	oldExtent := aPoint
]

{ #category : #sending }
BlMorphExtentChangedAnnouncement >> sendTo: anObject [

	^ anObject handleExtentChanged: self
]
