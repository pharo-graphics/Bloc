Class {
	#name : #BlCancellableTaskItAction,
	#superclass : #BlNotificableTaskItAction,
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #'api - execution' }
BlCancellableTaskItAction >> terminationRequested [
	^ self action terminate
]

{ #category : #testing }
BlCancellableTaskItAction >> wasCanceled [
	^ self action wasCanceled
]
