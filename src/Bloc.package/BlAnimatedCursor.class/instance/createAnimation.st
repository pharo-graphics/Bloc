as yet unclassified
createAnimation
	animation ifNotNil:[animation stop].
	imgIndex := 0.
	^ animation := BlAnimation new
		duration: 50;
		beInfinite;
		yourself