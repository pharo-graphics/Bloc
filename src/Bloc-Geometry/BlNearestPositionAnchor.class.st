"
I choose a point on a geometry path of the reference element which is the nearest to the other element
"
Class {
	#name : #BlNearestPositionAnchor,
	#superclass : #BlAnchorRelativeToElement,
	#instVars : [
		'nearestToElement'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlNearestPositionAnchor class >> nearestTo: aNearestElement from: aReferenceElement [
	<return: #BlNearestPositionAnchor>

	^ self new
		referenceElement: aReferenceElement;
		nearestToElement: aNearestElement
]

{ #category : #'instance creation' }
BlNearestPositionAnchor class >> referenceElement: anElement relatedTo: anotherElement [
	"Some types of achors should take other element into account"
	<return: #BlAnchorRelativeToElement>

	^ self nearestTo: anotherElement from: anElement
]

{ #category : #accessing }
BlNearestPositionAnchor >> nearestToElement [
	<return: #BlElement>

	^ nearestToElement
]

{ #category : #accessing }
BlNearestPositionAnchor >> nearestToElement: anElement [
	nearestToElement := anElement
]
