api - time
synchronized: aBlock
	"Make this time instance synchronized among all users.
	During evaluation of aBlock #now will return the same time, independent of
	how much time actually passed between calls"
	
	frozen := true.
	frozenTime := self currentTime.
	aBlock ensure: [
		frozen := false.
		frozenTime := nil ]