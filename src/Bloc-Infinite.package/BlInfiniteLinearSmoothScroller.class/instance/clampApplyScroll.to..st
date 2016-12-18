physics
clampApplyScroll: aTmpDelta to: aDelta
	<return: #Number>
	| aBefore tmpDt |
	
	aBefore := aTmpDelta.
	tmpDt := aTmpDelta - aDelta.
	
	(aBefore * tmpDt <= 0)
		"changed sign, reached 0 or was 0, reset"
		ifTrue: [ ^ 0 ].
	
	^ tmpDt