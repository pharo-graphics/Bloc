Extension { #name : #DateAndTime }

{ #category : #'*Bloc' }
DateAndTime class >> fromUTCMicrosecondClockValue: anInteger [

	| nanoTicks |
	nanoTicks := anInteger * 1000.
	^ self basicNew
		setJdn: Epoch 
		seconds: 0
		nano: nanoTicks
		offset: self localOffset
]

{ #category : #'*Bloc' }
DateAndTime >> utcMicroSeconds [
	
	^ ((((julianDayNumber - Epoch) * SecondsInDay) + seconds) * NanosInSecond + nanos) / 1000
]
