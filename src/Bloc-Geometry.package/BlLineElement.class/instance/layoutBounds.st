layout
layoutBounds
	| anOrigin aCorner |
	<return: #Rectangle>	

	anOrigin := self originPosition.
	aCorner := self cornerPosition.

	^ Rectangle encompassing: { anOrigin. aCorner }