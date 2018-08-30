Class {
	#name : #BlCancellableTaskItAction,
	#superclass : #BlNotificableTaskItAction,
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #accessing }
BlCancellableTaskItAction >> action: aCallback [
	super action: aCallback asCommand
]

{ #category : #'api - execution' }
BlCancellableTaskItAction >> cancelRequest [
	^ self action cancelRequest
]

{ #category : #testing }
BlCancellableTaskItAction >> wasCanceled [
	^ self action wasCanceled
]
