"
! The Infinite GT-Inspector Rendering Problem
 
We use ${class:GtInspector}$ extensions, defined by the ${class:BaselineOfGToolkitPhlow}$ framework. Those extensions are rendered in the background and actual views are displayed when the computation finishes.

We ended-up having an issue, that (even simple) views got stuck regularly. The problem was documented in the *GitHub issue 347>https://github.com/feenkcom/gtoolkit/issues/347* with the following screenshot:
+file://feenkcom/Bloc/doc/class-comment-support/feenk-issue-347.png+

!! The Problem Cause

${class:BlPulseStatSignal}$ and ${class:CurrentProcessSignal}$ showed that the Bloc pulse loop (${class:BlHostPulseLoop}$) was always taking longer than the pulse period (16ms) and thus was never allowing lower priority processes to run. Since ${class:GtInspector}$ uses ${class:GtPhlowTaskItView}$ to generate ${class:BlElement}$s, the actual work is done in a low priority task (priority 35), the rendering was prevented from completing.

The commit *feenkcom/Bloc@450dfe5>https://github.com/feenkcom/Bloc/commit/450dfe5b82731ea85fc8718b1d628ba83ee2d1de* modifies ${method:BlHostPulseLoop>>#wait}$ to check if there are low priority processes waiting for CPU time, and forces a minimum delay (currently 8ms) when there are.

!!Other Considerations

It is possible that the symptoms could be triggered by other causes:

- a large number of tasks are submitted to the background queue for window(s) that are either closed or hidden. We conclude that: (i) tasks should lower their priority if  their element or the window containing it is not visible; or (ii) tasks should finish immediately if their associated window is closed
- some other higher priority process is consuming all the available CPU time.
- a long-running task is running in the ${class:BlHostPulseLoop}$ (at UI priority), and would be better as a background UI task.

There are a number of tools that have been developed along the way to help identify issues:

- ${class:BlTaskItStatus}$ gives an overview of the Bloc-related TaskIt queues. Although there is a ${class:GtInspector}$ view that displays this information, the system is normally not responding when this is required, so it is more useful to write the string to a file.
- See also the class comments for: ${class:BlPulseStatSignal}$, ${class:CurrentProcessSignal}$ & ${class:BlSignalAnalysis}$

"
Class {
	#name : #BlTaskItRenderingProblemSolutionExplanation,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}
