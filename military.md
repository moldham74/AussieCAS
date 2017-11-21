# Military

_"In preparing for battle I have always found that plans are useless, but planning is indispensable"_ - Dwight D. Eisenhower

![BattleofBritain](websiteimages/DSC_1028 (1).jpg)

Agent-based models (ABMs) have been sucessfully applied to multiple research fields, with the application to military being one such field. While some of the applications are kept underwarps, this page provides a brief run down on the known appications of ABMs for military purposes. I also provide a brief run down on my contribution to the field. A lot of the information on this page came from Prof. Ken Comer's GMU CSS739 Agent-based Models: Military Applications course that was taught in the Fall of 2016.

## Why are ABMs applicaable to military conflicts?

Combat particularly land combat, possess the characteristics of a complex adaptive system (CAS). The justfication for conlcusion is based on the following: combat forces are composed of a large number of nonlinearly interacting parts and are organized in a dynamic command-and-control network; local action, which often appears disordered, self-organizes into long-range order; military conflicts, by their nature, proceed far from equilibrium; military forces adapt to a changing combat environment; and there is no master “voice” that dictates the actions of every soldier (i.e., battlefield action is decentralized). Nonetheless, it appears that most modern “state of the art” military simulations ignore the self-organizing properties of combat, hence the limited use of ABMs thus far in the field.

## Real World Military Applications

The use of simulation in the military is not anything new. The rationale for using simulations is that you can not run combat experiments in peacetime. Further, even in conflict, the concept of designed experimentation is not practical. Some of the earliest examples of military simulations, that predate the compute, include:

  -  Germany's [Kriegspiel wargame](https://en.wikipedia.org/wiki/Kriegsspiel_(wargame)) that was developed in the 1812; and
  -  U.S. Naval War College wargaming in 1930s.
  
With regard to the use of ABMs for the pruspose of combat simulation, numerous appeared in the 1990s, including;
   - ISAAC (Irreducible Semi-Autonomous Adaptive Combat) Model (1997) 
   - EINSTein (Enhanced ISAAC Neural Simulation Toolkit) Model (2000) 
   - Pythagoras agent-based combat model (c. 2002)
   
Of these EINSTein, made the greatest contribution, summary of the project and its results are found in Ilachinski's book [Artificial War](http://www.worldscientific.com/worldscibooks/10.1142/5531). The purpose of the research was to explore the applicability of complex adaptive systems theory to the study of warfare, and introduces a sophisticated multiagent-based simulation of combat called EINSTein. EINSTein, whose bottom-up, generative approach to modeling combat stands in stark contrast to the top-down or reductionist philosophy that still underlies most conventional military models, is designed to illustrate how many aspects of land combat may be understood as self-organized, emergent phenomena. Used worldwide by the military operations research community, EINSTein has pioneered the simulation of combat on a small to medium scale by using autonomous agents to model individual behaviors and personalities rather than hardware.

## Historical Military Application

While the benefits of ABMs have not been fully exploited by today's miliary, historians have used them to 

### Battle of Trafalgar

Complex model including wind, two kinds of combat, four classes of ships, varying crew efficiency, etc. ▫Both area winds and local winds (affected by sails) •Ships can “escape” of surrender based on their levels of casualties ▫With enough damage, ships can be sunk •Sails can be degraded, limiting mobility 

Matched all historical outcomes 

### Battle of Isandlwana

Strategic error: British believed their main risk was that the enemy would disperse ▫Sent out half their force on armed recce  ▫Badly underestimating enemy, British failed to entrench ▫Believed (based on experience) in the shock value of large force armed with breech-loading rifles •Remaining force failed to circle the wagons and form a “laager”, remained in a line •Result: complete annihilation of the British force at Isandlwana, retreat of columns

## My Contribution
### The Battle of Britian

The Churchillian quote "Never, in the field of human conflict, was so much owed by so many to so few", encapsulates perfectly the heroics of Royal Air Force (RAF) Fighter Command (FC) during the Battle of Britain. Despite the undoubted heroics, questions remain about how FC employed the "so few". In particular, the question as to whether FC should have employed the "Big Wing" tactics, as per 12 Group, or implement the smaller wings as per 11 Group, remains a source of much debate. In this paper, I create an agent based model (ABM) simulation of the Battle of Britain, which provides valuable insight into the key components that influenced the loss rates of both sides. It provides mixed support for the tactics employed by 11 Group, as the model identified numerous variables that impacted the success or otherwise of the British.

