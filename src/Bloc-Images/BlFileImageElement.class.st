"
BlFileImageElement provides a simple Bloc element for displaying images retrieved from disk.

BlFileImageElement takes care of retrieving and caching the image in a background process so that UI responsiveness is not affected.  The priority at which the background process runs, and the number of concurrent tasks is defined by the queue that the task is submitted to, see ${method:name=BlFileImageElement>>#taskPool}$.

!!Public API and Key Messages

Instances are created by simply passing the url as either a ${class:name=String}$ or ${class:name=ZnUrl}$, e.g.:

[[[
BlFileImageElement file: (FileLocator imageDirectory / 'pharo-local/iceberg/feenkcom/pillar/archetypes/academic/support/html/img/bubbles.jpg' )
]]]


 
!!Internal Representation and Key Implementation Points

!!!Instance Variables

	file:		<FileReference> The reference to the image being displayed


"
Class {
	#name : #BlFileImageElement,
	#superclass : #BlAsyncImageElement,
	#instVars : [
		'file'
	],
	#category : #'Bloc-Images-Elements'
}

{ #category : #accessing }
BlFileImageElement class >> file: aFileReference [

	^self new file: aFileReference
]

{ #category : #accessing }
BlFileImageElement >> file [ 

	^file
]

{ #category : #accessing }
BlFileImageElement >> file: aFileReference [
	"Load the supplied file in the background processor (which will update the receiver when done)"

	file := aFileReference asFileReference.
	self clearForm.
	self queueAsyncUpdate
]

{ #category : #accessing }
BlFileImageElement >> queueEntry [
	"Answer a TaskIt valuable that will update the receiver."

	^(BlTktUnresponsiveCommand new 
		valuable: (BlFileImageLoadValuable file: file element: self);
		name: file pathString;
		yourself) asBlTktLoggingCommand asBlTktSingleCommand
			identifier: self.

]

{ #category : #accessing }
BlFileImageElement >> taskPool [
	^ BlTktWorkerProvider highUICPUBoundPool 
]
