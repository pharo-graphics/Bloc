initialization
rope: aRope spans: anArrayOfSpans
	spans := anArrayOfSpans.
	rope := aRope.
	from := spans ifEmpty: [ 0 ] ifNotEmpty: [ spans first from ].
	to := spans ifEmpty: [ 0 ] ifNotEmpty: [ spans last to ].
	width := spans ifEmpty: [ 0 ] ifNotEmpty: [ spans sum: #width ].
	height := spans ifEmpty: [ 0 ] ifNotEmpty: [ (spans detectMax: #height) height ].
	ascent := spans ifEmpty: [ 0 ] ifNotEmpty: [ (spans detectMax: #ascent) ascent ].
	descent := spans ifEmpty: [ 0 ] ifNotEmpty: [ (spans detectMax: #descent) descent ].
	length := spans ifEmpty: [ 0 ] ifNotEmpty: [ spans sum: #length ]