Class {
	#name : #BlAnchorParentReceiver,
	#superclass : #BlAnchorReceiver,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #initialization }
BlAnchorParentReceiver >> inParent: anElement forChild: aChild [

	^ BlAnchorExplicitReceiver new
		  element: anElement;
		  yourself
]
