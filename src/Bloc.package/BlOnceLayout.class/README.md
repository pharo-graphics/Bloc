I am a Layout decorator that makes other layouts to be computed only once.

Example:

[[[
	| aLayout |	
	
	aLayout := BlOnceLayout on: BlGridLayout new.
	aLayout isStopped. "false"
	".... after layout is done...."
	aLayout isStopped. "true"
]]]