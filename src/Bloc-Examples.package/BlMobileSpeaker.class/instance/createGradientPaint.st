as yet unclassified
createGradientPaint
	^ BlLinearGradientPaint new
		stops:
			{(0.0 -> (Color veryDarkGray alpha: 0.3)).
			(0.3 -> (Color veryDarkGray alpha: 0.7)).
			(0.6 -> (Color veryDarkGray alpha: 0.7)).
			(1.0 -> (Color veryDarkGray alpha: 0.3))};
		start: (BlMobilePhone pxSpeakerWidth / 2) @ 0;
		end: (BlMobilePhone pxSpeakerWidth / 2) @ BlMobilePhone pxSpeakerHeight;
		yourself