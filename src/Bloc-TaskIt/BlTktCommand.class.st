Class {
	#name : #BlTktCommand,
	#superclass : #BlTktProtoCommand,
	#instVars : [
		'requests'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #initialization }
BlTktCommand >> initialize [
	super initialize.
	requests := BlTktCommandRequests new.
]

{ #category : #accessing }
BlTktCommand >> requestContext [
	<return: #TBlTktRequests>
	^ requests
]
