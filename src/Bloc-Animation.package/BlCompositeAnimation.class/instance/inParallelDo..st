api
inParallelDo: aBlock
	|anim|
	anim := BlParallelAnimation new.
	aBlock value: anim.
	self add: anim.