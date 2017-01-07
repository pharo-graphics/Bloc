change reporting
requestNextPulse
	nextPulseRequested := true.
	
	"By the contract next pulse can be only requested if universe is running.
	It is done to not create pulse loop when it is actually not needed (for example during testing)"
	BlUniverse default isRunning
		ifTrue: [ BlUniverse default requestNextPulse ]