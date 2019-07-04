"
! The Infinite GT-Inspector Redering Problem
 
We use ${class:GtInspector}$ extensions, defined by the ${class:BaselineOfGToolkitPhlow}$ framework. Those extensions are rendered on a background and actual views are displayed when the computation finishes.

We ended-up having an issue, that (even simple) views got stuck regularly. The problem was documented in the *GitHub issue 347>https://github.com/feenkcom/gtoolkit/issues/347* with the following screenshot:
+file://feenkcom/Bloc/doc/class-comment-support/feenk-issue-347.png+

!! The Problem Cause

${class:BlPulseStatSignal}$ and ${class:CurrentProcessSignal}$ showed that the Bloc pulse loop (${class:BlPulseLoop}$) was always taking longer than the pulse period (16ms) and thus was never allowing lower priority processes to run. Since ${class:GtInspector}$ uses ${class:GtPhlowTaskItView}$ to generate ${class:BlElement}$ the actual work is done in a low priority task (priority 35), preventing the Rendering from completing.

The commit *feenkcom/Bloc@450dfe5>https://github.com/feenkcom/Bloc/commit/450dfe5b82731ea85fc8718b1d628ba83ee2d1de* modifies ${method:BlPulseLoop>>#wait}$ to check if there are low priority processes waiting for CPU time, and forces a minimum delay (currently 8ms) when there are.

!!Other Considerations

It is possible that the symptoms could be triggered by other causes:

- a large number of tasks are submitted to the background queue for window(s) that are either closed or hidden. We conclude that: (i) tasks should lower their priority if the window or their element is not visible; or (ii) tasks should finish immediately if their associated window is closed
- some other higher priority process is consuming all the available CPU time.
- a task run within the ${class:BlPulseLoop}$ (at UI priority) that is long running that would be better run as a background UI task.

There are a number of tools that have been developed along the way to help identify issues:

- ${class:BlTaskItStatus}$ gives an overview the Bloc related TaskIt queues. While there is a ${class:GtInspector}$ view that displays the status, the system is normally not responding when this is required, so it is better to write the string to a file (convenience method should be added).
- TBC: ${class:BlPulseStatSignal}$. ${class:CurrentProcessSignal}$ & ${class:BlSignalAnalysis}$

"
Class {
	#name : #BlTaskItRenderingProblemSolutionExplanation,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}
