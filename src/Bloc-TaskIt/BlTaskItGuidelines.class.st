"
! Bloc-TaskIt Process Guidelines

Building responsive applications require dealing with processes responsible for long-time computation and giving back to an user interface an answer, when it is ready. 

Applications can therefore end-up with many processes. In addition, those processes can spawn sub-processes. Check the following example (look at the scrollbar):
+Process Browser with many processes>file://feenkcom/Bloc/doc/class-comment-support/process-inflation-issue.png+ 

To manage and deal with such information, we need to keep a control of it. For example, developers should understand the process hierarchy and which graphical widget (application) spawned what process.

!! Considerations

- Processes should be created in unified way, a common API.
- We should have tools to deal with possible process issues, e.g., too many processes running in the background.
- ${class:BlTaskItStatus}$ to be live (a few more views).
- Submitted tasks could have a name (and maybe a source).
- ${class:BlTaskItStatus}$ could then provide a view showing the currently executing tasks (by name (and source))
- TaskIt also has a process viewer, but I've never been able to make sense of it.  (It's not loaded by default)
- It would also be good to have an overview of all the tasks queued against ${class:BlElement}$ instances and ${class:BlSpace}$. 
 
 
!! Common API
 
 
"
Class {
	#name : #BlTaskItGuidelines,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}
