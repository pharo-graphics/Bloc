Class {
	#name : #BlCancellableTaskItAction,
	#superclass : #BlNotificableTaskItAction,
	#traits : 'TBlTktRequests',
	#classTraits : 'TBlTktRequests classTrait',
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlCancellableTaskItAction >> action: aCallback [
	super action: aCallback asBlTktCommand
]

{ #category : #accessing }
BlCancellableTaskItAction >> requestContext [
	<return: #TBlTktRequests>
	^ self action
]

{ #category : #'api - execution' }
BlCancellableTaskItAction >> terminationRequested [
	^ self action terminationRequested
]

{ #category : #testing }
BlCancellableTaskItAction >> wasCanceled [
	^ self action wasCanceled
]
