Class {
	#name : #BlTaskProgress,
	#superclass : #Notification,
	#category : #'Bloc-TaskIt-Signals'
}

{ #category : #signalling }
BlTaskProgress class >> signal [
	"Create and signal progress."

	^ BlSignalProgress ifEnabledDo: [ 
			BlAnyProgress signal ]
]

{ #category : #signalling }
BlTaskProgress class >> signal: signalerText [
	"Create and signal progress with
	an additional signalerText."

	^ BlSignalProgress ifEnabledDo: [ 
			BlAnyProgress signal: signalerText ]
]

{ #category : #signalling }
BlTaskProgress class >> signal: signalerText amount: amount [
	"Create and signal progress with amount units transferred out of total.
	Use an additional signalerText."

	^ BlSignalProgress ifEnabledDo: [ 
			BlSomeProgress
				signal: signalerText amount: amount ]
]

{ #category : #signalling }
BlTaskProgress class >> signal: signalerText amount: amount total: total [
	"Create and signal progress with amount units transferred out of total.
	Use an additional signalerText."

	^ BlSignalProgress ifEnabledDo: [ 
			BlProgress
				signal: signalerText 
				amount: amount 
				total: total ]
]

{ #category : #signalling }
BlTaskProgress class >> signalAmount: amount [
	"Create and signal progress with amount units."

	^ BlSignalProgress ifEnabledDo: [ 
			BlSomeProgress
				signalAmount: amount ]
]

{ #category : #signalling }
BlTaskProgress class >> signalAmount: amount total: total [
	"Create and signal progress with amount units transferred out of total."
	
	^ BlSignalProgress ifEnabledDo: [ 
			BlProgress
				signalAmount: amount 
				total: total ]
]
