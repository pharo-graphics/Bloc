Extension { #name : #Color }

{ #category : #'*Bloc-Alexandrie-Tests' }
Color class >> random: aRandom [
	"Return a random color that isn't too dark or under-saturated."

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/840'.
		
	^ self 
		h: (360.0 * aRandom next)
		s: (0.3 + (aRandom next * 0.7))
		v: (0.4 + (aRandom next * 0.6))

]
