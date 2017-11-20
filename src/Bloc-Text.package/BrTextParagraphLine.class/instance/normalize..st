measurement
normalize: aScale
	"Normalize this segment to have rounded measurements.
	I don't change the baseline"

	spans
		ifEmpty: [ ^ self ].
		
	spans do: [ :aSpan | aSpan normalize: aScale ].
	
	self layout