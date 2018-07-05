rope
concatenate: aLeftRope and: aRightRope
	| totalSize |
	aLeftRope isEmpty
		ifTrue: [ ^ aRightRope ].

	aRightRope isEmpty 
		ifTrue: [ ^ aLeftRope ].

	totalSize := aLeftRope size + aRightRope size.
	
	"if both ropes are leafs we can simplify concatenation"
	(aLeftRope isLeaf and: [ aRightRope isLeaf ])
		ifTrue: [ 
			^ totalSize <= self combineLength
				ifTrue: [ self collectionRope from: aLeftRope and: aRightRope ]
				ifFalse: [ self concatenationRope left: aLeftRope right: aRightRope ] ].

	"left rope is not concatenation while right is"
	(aLeftRope isConcatenation not and: [ aRightRope isConcatenation ])
		ifTrue: [ 
			| newLeft |
			newLeft := self concatenate: aLeftRope and: aRightRope left.
			^ newLeft isConcatenation
				ifTrue: [ self concatenationRope left: newLeft right: aRightRope right ]
				ifFalse: [ self concatenate: newLeft and: aRightRope right ] ].

	"right rope is not concatenation while left is"
	(aRightRope isConcatenation not and: [ aLeftRope isConcatenation ])
		ifTrue: [ 
			| newRight |
			newRight := self concatenate: aLeftRope right and: aRightRope.
			^ newRight isConcatenation
				ifTrue: [ self concatenationRope left: aLeftRope left right: newRight ]
				ifFalse: [ self concatenate: aLeftRope left and: newRight ] ].
	
	((aLeftRope size + aRightRope size > (self combineLength)) and: [ (aLeftRope size * 2) < aRightRope size ])
		ifTrue: [ 
			| aMiddle |
			aMiddle := ((aLeftRope size + aRightRope size) / 2.0) floor asInteger - aLeftRope size.
			^ self concatenationRope
				left: (aLeftRope append: (aRightRope from: 1 to: aMiddle))
				right: (aRightRope from: aMiddle + 1 to: aRightRope size) ].
	
	
	^ self concatenationRope left: aLeftRope right: aRightRope