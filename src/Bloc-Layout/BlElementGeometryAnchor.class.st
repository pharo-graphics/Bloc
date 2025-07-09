Class {
	#name : #BlElementGeometryAnchor,
	#superclass : #BlAnchor,
	#instVars : [
		'receiver'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementGeometryAnchor >> checkInParent: anElement forChild: aChild [

	receiver := receiver inParent: anElement forChild: aChild
]

{ #category : #accessing }
BlElementGeometryAnchor >> element [
	self assert: receiver element notNil.
	^ receiver element
]

{ #category : #accessing }
BlElementGeometryAnchor >> element: anElement [

	receiver := BlAnchorExplicitReceiver new
		            element: anElement;
		            yourself
]

{ #category : #initialization }
BlElementGeometryAnchor >> initialize [ 

	super initialize.
	receiver := BlAnchorChildReceiver new
]

{ #category : #accessing }
BlElementGeometryAnchor >> receiver [

	^ receiver
]

{ #category : #accessing }
BlElementGeometryAnchor >> receiver: anAnchorReceiver [

	receiver := anAnchorReceiver
]
