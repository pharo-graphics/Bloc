Class {
	#name : #BlDemoApplication,
	#superclass : #SpApplication,
	#category : #'Bloc-Demo'
}

{ #category : #running }
BlDemoApplication >> run [ 
	(self new: BlDemoPresenter) open
]
