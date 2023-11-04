Class {
	#name : #BlFlowLayoutInlineChild,
	#superclass : #BlFlowLayoutChild,
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #adding }
BlFlowLayoutInlineChild >> addToLine: aLine [
	
	(self orientation isHorizontal and: [ self direction isRightToLeft ])
		ifTrue: [ aLine addInlineFirst: self ]
		ifFalse: [ aLine addInlineLast: self ]
]
