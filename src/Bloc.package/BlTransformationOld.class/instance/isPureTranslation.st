testing
isPureTranslation
	"Return true if the receiver specifies no rotation or scaling."

	^ sx = 1.0 and: [sy = 1.0 and: [ shx = 0.0 and: [ shy = 0.0 ] ] ]