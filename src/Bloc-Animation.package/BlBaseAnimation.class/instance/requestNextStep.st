pulse
requestNextStep
	"Request next animation step if animation is not done yet
	or still waiting to start becasue of delay"
	
	BlUniverse default isRunning
		ifTrue: [ BlUniverse default requestNextPulse ]