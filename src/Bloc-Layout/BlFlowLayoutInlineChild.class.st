Class {
	#name : 'BlFlowLayoutInlineChild',
	#superclass : 'BlFlowLayoutChild',
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'adding' }
BlFlowLayoutInlineChild >> addToLine: aLine [
	
	(self orientation isHorizontal and: [ self direction isRightToLeft ])
		ifTrue: [ aLine addInlineFirst: self ]
		ifFalse: [ aLine addInlineLast: self ]
]
