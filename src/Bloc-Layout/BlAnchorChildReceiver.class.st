Class {
	#name : #BlAnchorChildReceiver,
	#superclass : #BlAnchorReceiver,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #initialization }
BlAnchorChildReceiver >> inParent: anElement forChild: aChild [

	^ BlAnchorExplicitReceiver new
		  element: aChild;
		  yourself
]
