private - time
currentTime
	"Return a 'current' date and time"
	<return: #DateAndTime>
	| aSpeededTime aDelta aCurrentRealTime |
	
	aCurrentRealTime := DateAndTime now.
	
	aDelta := aCurrentRealTime - previousRealTime.
	
	aSpeededTime := previousSpeededUpTime + (aDelta * self speed).
	
	previousSpeededUpTime := aSpeededTime.
	previousRealTime := aCurrentRealTime.
	
	^ aSpeededTime