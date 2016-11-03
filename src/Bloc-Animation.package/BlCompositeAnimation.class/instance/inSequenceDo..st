api
inSequenceDo: aBlock
	|anim|
	anim := BlSequentialAnimation new.
	aBlock value: anim.
	self add: anim.