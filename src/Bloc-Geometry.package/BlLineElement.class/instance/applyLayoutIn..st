layout
applyLayoutIn: aBounds
	| anOrigin aCorner |

	anOrigin := self originPosition.
	aCorner := self cornerPosition.

	super applyLayoutIn: (Rectangle encompassing: { anOrigin. aCorner }).