examples - delete
delete_left_part
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: 1 to: anOriginalRope left size.

	self assert: anUpdatedRope == anOriginalRope right.

	^ anUpdatedRope