as yet unclassified
createGradientPaint
	^ BlLinearGradientPaint new
		stops:
			{(0.0 -> Color gray).
			(0.3 -> Color darkGray).
			(0.6 -> Color darkGray).
			(1.0 -> Color gray)};
		start: (BlMobilePhone pxSpeakerWidth / 2) @ 0;
		end: (BlMobilePhone pxSpeakerWidth / 2) @ BlMobilePhone pxSpeakerHeight;
		yourself