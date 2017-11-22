# Military

_"In preparing for battle I have always found that plans are useless, but planning is indispensable"_ - Dwight D. Eisenhower

![BattleofBritain](websiteimages/DSC_1028 (1).jpg)

Agent-based models (ABMs) have been sucessfully applied to multiple research fields, with the application to military being one such field. While some of the applications are kept underwarps, this page provides a brief run down on the known appications of ABMs for military purposes. I also provide a brief run down on my contribution to the field. A lot of the information on this page came from Prof. Ken Comer's GMU CSS739 Agent-based Models: Military Applications course that was taught in the Fall of 2016.

## Why are ABMs Applicable to Military Conflicts?

Combat particularly land combat, possess the characteristics of a complex adaptive system (CAS). The justfication for conlcusion is based on the following: combat forces are composed of a large number of nonlinearly interacting parts and are organized in a dynamic command-and-control network; local action, which often appears disordered, self-organizes into long-range order; military conflicts, by their nature, proceed far from equilibrium; military forces adapt to a changing combat environment; and there is no master “voice” that dictates the actions of every soldier (i.e., battlefield action is decentralized). Nonetheless, it appears that most modern “state of the art” military simulations ignore the self-organizing properties of combat, hence the limited use of ABMs thus far in the field.

## Real World Military Applications

The use of simulation in the military is not anything new. The rationale for using simulations is that you can not run combat experiments in peacetime. Further, even in conflict, the concept of designed experimentation is not practical. Some of the earliest examples of military simulations, that predate the compute, include:

  -  Germany's [Kriegspiel wargame](https://en.wikipedia.org/wiki/Kriegsspiel_(wargame)) that was developed in the 1812; and
  -  U.S. Naval War College wargaming in 1930s.
  
Lanchester equations Lanchester developed a mathematical model addressing the implications of various combat scenarios, including directed fire. . However, problems that can arise when simulating combat situations using the Lanchester models are spatially and temporally homogenous, allowing for no variation in unit type, terrain or tactics, command or control, skill or doctrine. These assumptions appear inconsistent with modern warfare, which is ultimately dynamic and heterogeneous, thus the need for alternative approach exists.
  
With regard to the use of ABMs for the pruspose of combat simulation, numerous appeared in the 1990s, including;
   - ISAAC (Irreducible Semi-Autonomous Adaptive Combat) Model (1997) 
   - EINSTein (Enhanced ISAAC Neural Simulation Toolkit) Model (2000) 
   - Pythagoras agent-based combat model (c. 2002)
   
Of these EINSTein, made the greatest contribution, summary of the project and its results are found in Ilachinski's book [Artificial War](http://www.worldscientific.com/worldscibooks/10.1142/5531). The purpose of the research was to explore the applicability of complex adaptive systems theory to the study of warfare, and introduces a sophisticated multiagent-based simulation of combat called EINSTein. EINSTein, whose bottom-up, generative approach to modeling combat stands in stark contrast to the top-down or reductionist philosophy that still underlies most conventional military models, is designed to illustrate how many aspects of land combat may be understood as self-organized, emergent phenomena. Used worldwide by the military operations research community, EINSTein has pioneered the simulation of combat on a small to medium scale by using autonomous agents to model individual behaviors and personalities rather than hardware.

## Historical Military Application

While the benefits of ABMs have not been fully exploited by today's miliary, historians have used them to great effect to reconstruct militaray campaigns for the purpose of what went right and wrong for the combatants. Two examples inlcude

### Battle of Trafalgar

[Trautteur and Virgilio (2003)](papers/Trautteur2003.pdf) implemented an ABM that analyzed the famous naval [Battle of Trafalgar](https://en.wikipedia.org/wiki/Battle_of_Trafalgar). Features of the model, which all highlight the utility of ABMs, included area winds and local winds, two kinds of combat, four classes of ships, varying crew efficiency, etc. The ships “escaped” or surrendered based on their levels of casualties. Damage also played a part with ships either sunk or their performance diminished.

The results agreed in a very strict way with historical data. A comparison between the computational model and Lanchester’s analytical model was also provided. In a key finding the forecasts from the Lanchester model were substantial different to the results obtained by the computational model - and the actual outcome. 

### Battle of Isandlwana

[Scogings and Hawick (2012)](papers/Scogings2012.pdf) provided a simulation of the [Battle of Isandlwana](https://en.wikipedia.org/wiki/Battle_of_Isandlwana) with considerable historical accuracy. Additionally, altered the inputs to demonstrate a plausible alternative to history. The histrorical interest in the battle is that the British made a number of stratgeic errors including, underestimating the enemy, and overestimating the effectiveness of their weapons. This lead to poor defensive tactics by the British, which eventually saw their annihilation in the battle and their forced retreat.

## My Contribution

After being tasked with implementing an ABM with a military theme in CSS739, I combined my love of World War II (WWII) history, and my new found knowledge of military simulation techniques. The result was my awarding winning (winner of the best paper at the 16th MABs confernce) To [Big Wing, or Not to Big Wing, Now an Answer](https://link.springer.com/chapter/10.1007/978-3-319-46882-2_5) paper. For this paper I lucky enough to lean on the previous work of the [York Historical Warfare Analysis Group](http://www-users.york.ac.uk/~nm15/ynt/YHWAG.html).

### The Battle of Britian

<iframe width="650" height="365" src="https://www.youtube.com/embed/CkKZSvwvY3w" frameborder="0" gesture="media" allowfullscreen></iframe>

The Churchillian quote "Never, in the field of human conflict, was so much owed by so many to so few", encapsulates perfectly the heroics of Royal Air Force (RAF) Fighter Command (FC) during the Battle of Britain. Despite the undoubted heroics, questions remain about how FC employed the "so few". In particular, the question as to whether FC should have employed the "Big Wing" tactics, as per 12 Group, or implement the smaller wings as per 11 Group, remains a source of much debate. In this paper, I create an agent based model (ABM) simulation of the Battle of Britain, which provides valuable insight into the key components that influenced the loss rates of both sides. It provides mixed support for the tactics employed by 11 Group, as the model identified numerous variables that impacted the success or otherwise of the British.

## References
Scogings, C., & Hawick, K. (2012). An agent-based model of the Battle of Isandlwana (pp. 1–12). IEEE. [https://doi.org/10.1109/WSC.2012.6465043](https://doi.org/10.1109/WSC.2012.6465043)

Trautteur, G., & Virgilio, R. (2003). An agent-based computational model for the Battle of Trafalgar: a comparison between analytical and simulative methods of research (pp. 377–382). IEEE Comput. Soc. [https://doi.org/10.1109/ENABL.2003.1231440](https://doi.org/10.1109/ENABL.2003.1231440)

