"
${class:BlHousekeepingWorkerPool}$ is a ${class:TKTCommonQueueWorkerPool}$ that runs the workers at ${method:ProcessorScheduler>>#userBackgroundPriority}$ and limits the number of concurrent tasks so that the UI thread is still responsive.

!!Public API and Key Messages

The public API and key messages are the same as for ${class:TKTCommonQueueWorkerPool}$.

"
Class {
	#name : #BlHousekeepingWorkerPool,
	#superclass : #BlVariableSizeWorkerPool,
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #accessing }
BlHousekeepingWorkerPool class >> defaultName [
	"Return a default worker pool name"
	<return: #String>
	^ 'Housekeeping'
]

{ #category : #accessing }
BlHousekeepingWorkerPool class >> defaultPoolSize [
	"Return a default worker pool size"
	<return: #Integer>
	^ 1
]

{ #category : #'class initialization' }
BlHousekeepingWorkerPool class >> initialize [ 
	<script>

	self stopAll.
	workerPools := Dictionary new.

]

{ #category : #accessing }
BlHousekeepingWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTKTHousekeepingProcessProvider new
]
