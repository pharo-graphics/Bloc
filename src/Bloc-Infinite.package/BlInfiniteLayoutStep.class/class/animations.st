accessing
animations
	^ animationsStep ifNil: [ animationsStep := BlInfiniteLayoutStepAnimations new ]