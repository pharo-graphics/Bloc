as yet unclassified
testDeferredAction
| flag|
flag := false.
 BlUniverse default start;
defer: [ flag := true.  self assert:(BlUniverse default isUIProcess: Processor preemptedProcess) ].

(Delay forSeconds: 1) wait.
self assert: flag.

BlUniverse reset.