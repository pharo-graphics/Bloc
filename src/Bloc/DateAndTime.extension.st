Extension { #name : #DateAndTime }

{ #category : #'*Bloc' }
DateAndTime class >> fromUTCMicrosecondClockValue: anInteger [

	| nanoTicks epoch |
	
	"Ugly, but I have to handle the rename of the SharedPool variable"
	epoch := ((self bindingOf: #Epoch) ifNil: [ (self bindingOf: #SqueakEpoch) ]) value.
	
	nanoTicks := anInteger * 1000.
	^ self basicNew
		setJdn: epoch 
		seconds: 0
		nano: nanoTicks
		offset: self localOffset
]

{ #category : #'*Bloc' }
DateAndTime >> utcMicroSeconds [
	
	^ ((((julianDayNumber - Epoch) * SecondsInDay) + seconds) * NanosInSecond + nanos) / 1000
]
