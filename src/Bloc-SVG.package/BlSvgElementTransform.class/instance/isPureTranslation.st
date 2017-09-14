testing
isPureTranslation
	^ skewX = 0.0 and: [
		skewY = 0.0 and: [
			skewZ = 0.0 and: [
				super isPureTranslation ] ]]