examples - delete
delete_right_part
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: anOriginalRope left size + 1 to: anOriginalRope size.

	self assert: anUpdatedRope == anOriginalRope left.

	^ anUpdatedRope