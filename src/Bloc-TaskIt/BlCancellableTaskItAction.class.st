Class {
	#name : #BlCancellableTaskItAction,
	#superclass : #BlNotificableTaskItAction,
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlCancellableTaskItAction >> action: aCallback [
	super action: aCallback asBlTktCommand
]

{ #category : #'api - execution' }
BlCancellableTaskItAction >> terminationRequested [
	^ self action terminationRequested
]

{ #category : #testing }
BlCancellableTaskItAction >> wasCanceled [
	^ self action wasCanceled
]
