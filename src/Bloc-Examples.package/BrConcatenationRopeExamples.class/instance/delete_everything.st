examples - delete
delete_everything
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: 1 to: anOriginalRope size.

	self assert: (anUpdatedRope isKindOf: BlCollectionRope).
	self assert: anUpdatedRope isEmpty.

	^ anUpdatedRope