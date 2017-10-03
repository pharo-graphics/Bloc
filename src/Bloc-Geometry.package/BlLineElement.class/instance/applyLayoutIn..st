layout
applyLayoutIn: aBounds
	| anOrigin aCorner |

	anOrigin := self originPosition.
	aCorner := self cornerPosition.
	
	WrapperSignal emit: anOrigin -> aCorner.

	super applyLayoutIn: (Rectangle encompassing: { anOrigin. aCorner }).