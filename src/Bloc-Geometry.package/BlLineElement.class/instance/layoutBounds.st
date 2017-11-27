layout
layoutBounds
	| anOrigin aCorner |
	<return: #Rectangle>	

	anOrigin := self fromPosition.
	aCorner := self toPosition.

	^ Rectangle encompassing: { anOrigin. aCorner }