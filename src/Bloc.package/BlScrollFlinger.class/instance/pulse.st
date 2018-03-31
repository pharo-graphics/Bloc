running
pulse
	"To work with animation manager"
	
	(BlUniverse default animationManager includesAnimation: self)
		ifTrue: [ BlUniverse default animationManager removeAnimation: self ].

	self run