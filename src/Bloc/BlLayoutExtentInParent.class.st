Class {
	#name : #BlLayoutExtentInParent,
	#superclass : #BlLayoutExtent,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - converting' }
BlLayoutExtentInParent >> inLocal [
	<return: #BlLayoutExtentInLocal>

	^ BlLayoutExtentInLocal new
		width: self width;
		height: self height
]

{ #category : #'api - converting' }
BlLayoutExtentInParent >> inParent [
	<return: #BlLayoutExtentInParent>

	^ self
]
