deferred actions
defer: aValuable
"#defer: can be used from any thread to execute a valuable in the GUI thread
You can use it to update the GUI states from any other thread.
The valuable will be evaluated as soon as possible.
"
	deferredActions nextPut: aValuable