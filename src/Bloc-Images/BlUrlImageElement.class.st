"
BlUrlImageElement provides a simple Bloc element for displaying images retrieved over the internet.

BlUrlImageElement takes care of retrieving and caching the image in a background process so that UI responsiveness is not affected.  The priority at which the background process runs, and the number of concurrent tasks is defined by the queue that the task is submitted to, see ${method:name=BlUrlImageElement>>#taskPool}$.


!!Public API and Key Messages

Instances are created by simply passing the url as either a ${class:name=String}$ or ${class:name=ZnUrl}$, e.g.:

[[[
BlUrlImageElement url: 'https://pharo.org/web/files/pharo.png'
]]]


 
!!Internal Representation and Key Implementation Points

!!!Instance Variables

	url:		<ZnUrl> The URL of the image being displayed


"
Class {
	#name : #BlUrlImageElement,
	#superclass : #BlAsyncImageElement,
	#instVars : [
		'url'
	],
	#category : #'Bloc-Images-Elements'
}

{ #category : #accessing }
BlUrlImageElement class >> url: aZnUrl [

	^self new url: aZnUrl
]

{ #category : #'async processing' }
BlUrlImageElement >> queueEntry [
	"Answer a TaskIt valuable that will update the receiver."

	^(BlTktUnresponsiveCommand new 
		valuable: (BlUrlImageLoadValuable url: url element: self);
		name: url asString;
		yourself) asBlTktLoggingCommand asBlTktSingleCommand
			identifier: self.


]

{ #category : #accessing }
BlUrlImageElement >> taskPool [
	^ BlTktWorkerProvider highUIExternalResourceBoundPool
]

{ #category : #accessing }
BlUrlImageElement >> url [
	^ url
]

{ #category : #accessing }
BlUrlImageElement >> url: aZnUrl [

	url := aZnUrl asZnUrl.
	self clearForm.
	self queueAsyncUpdate
]
