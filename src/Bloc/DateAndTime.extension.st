Extension { #name : #DateAndTime }

{ #category : #'*Bloc' }
DateAndTime class >> epochValue [ 

	"Ugly, but I have to handle the rename of the SharedPool variable"
	^ ((self bindingOf: #Epoch) ifNil: [ (self bindingOf: #SqueakEpoch) ]) value.

]

{ #category : #'*Bloc' }
DateAndTime class >> fromUTCMicrosecondClockValue: anInteger [

	| nanoTicks |
		
	nanoTicks := anInteger * 1000.
	^ self basicNew
		setJdn: self epochValue 
		seconds: 0
		nano: nanoTicks
		offset: self localOffset
]

{ #category : #'*Bloc' }
DateAndTime >> utcMicroSeconds [
	
	^ ((((julianDayNumber - self class epochValue) * SecondsInDay) + seconds) * NanosInSecond + nanos) / 1000
]
