dnd handlers
dragEvent: anEvent
	| dragPosition dragDelta |

	dragPosition := anEvent currentTarget globalPointToParent: anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	anEvent currentTarget relocate: (originalPosition + dragDelta).

	anEvent consumed: true