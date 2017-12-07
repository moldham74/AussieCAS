# Military

_"In preparing for battle I have always found that plans are useless, but planning is indispensable"_ - Dwight D. Eisenhower

![BattleofBritain](websiteimages/DSC_1028 (1).jpg)

Agent-based models (ABMs) have been successfully applied to multiple research fields, with the application to the military being one such field. While some of the applications are kept under wraps, this page provides a brief run down on the known applications of ABMs for military purposes. I also provide a brief rundown of my contribution to the field. A lot of the information on this page came from Prof. Ken Comer’s GMU CSS739 Agent-based models: Military Applications course that was taught in the Fall of 2016.

## Why are ABMs applicable to military conflicts?

Combat, particularly land combat, possesses the characteristics of a complex adaptive system (CAS). The justification for this statement is based on the following: combat forces are composed of a large number of nonlinearly interacting parts, and are organized in a dynamic command-and-control network; local action, which often appears disordered, self-organizes into long-range order; military conflicts, by their nature, proceed far from equilibrium; military forces adapt to a changing combat environment; and there is no master “voice” that dictates the actions of every soldier (i.e., battlefield action is decentralized). Nonetheless, it appears that most modern “state of the art” military simulations ignore the self-organizing properties of combat, hence the limited use of ABMs thus far in the field.

## Examples of real-world military utilization

The use of simulation in the military is not anything new. The rationale for using simulations is that you cannot run combat experiments in peacetime. Further, even in conflict, the concept of designed experimentation is not practical. Some of the earliest examples of military simulations that predate the computer include:

  -  Germany's <a href="https://en.wikipedia.org/wiki/Kriegsspiel_(wargame)" target="blank">Kriegspiel wargame</a> that was launched in 1812; and
  -  U.S. Naval War College war gaming in the 1930s.
  
Another advancement in military simulations was the introduction and acceptance of the Lanchester equations. Via a set differential equations Lanchester model provides expected losses under various combat scenarios, including directed fire. However, problems arise when simulating combat situations using the Lanchester models because the model is spatially and temporally homogenous, thus not allowing for variations in unit type, terrain or tactics, command or control, skill or doctrine. These assumptions appear inconsistent with modern warfare, which is ultimately dynamic and heterogeneous; thus the need for alternative approach exists.
  
The use of ABMs for the purpose of combat simulation first appeared in the 1990s, The known models include;

   - ISAAC (Irreducible Semi-Autonomous Adaptive Combat) Model (1997) 
   - EINSTein (Enhanced ISAAC Neural Simulation Toolkit) Model (2000) 
   - Pythagoras agent-based combat model (c. 2002)
   
Of these EINSTein, made the greatest contribution. A summary of the project and its results are found in <a href="http://www.worldscientific.com/worldscibooks/10.1142/5531" target="blank">Artificial War</a>. The purpose of the research was to explore the applicability of complex adaptive systems theory to the study of warfare, and it introduced a sophisticated multiagent-based simulation of combat called EINSTein. EINSTein’s bottom-up, generative approach to modeling combat contrasts with the top-down approach that still underlies most conventional military models. The model illustrates how many aspects of land combat may be understood as self-organized, emergent phenomena. 

## Examples of historical military utilization

While the benefits of ABMs have not been fully exploited by today's military, historians have used them to great effect to reconstruct military campaigns to try and understand what went right and wrong for the combatants. Two examples include:

### Battle of Trafalgar

[Trautteur and Virgilio (2003)](papers/Trautteur2003.pdf) implemented an ABM that analyzed the famous naval <a href="https://en.wikipedia.org/wiki/Battle_of_Trafalgar" target="blank">Battle of Trafalgar</a>. Features of the model, which highlight the utility of ABMs, included area winds and local winds, two kinds of combat, four classes of ships, varying crew efficiency, etc. The ships “escaped” or surrendered based on their levels of casualties. Damage also played a part with ships either sunk or their performance diminished.

The results of the model agreed in a very strict way with historical data. A comparison between the computational model and Lanchester’s analytical model was also provided. In a key finding, the predictions from the Lanchester model were substantially different from the results obtained by the computational model - and from the actual outcome. 

### Battle of Isandlwana

[Scogings and Hawick (2012)](papers/Scogings2012.pdf) provided a simulation of the <a href="https://en.wikipedia.org/wiki/Battle_of_Isandlwana" target="blank">Battle of Isandlwana</a> with considerable historical accuracy.  The historical interest in the battle is that the British made a number of strategic errors, including underestimating the enemy and overestimating the effectiveness of their weapons. This led to poor defensive tactics by the British, which eventually saw their annihilation in the battle and their forced retreat. Additionally, the authors altered various inputs to the model to demonstrate plausible alternatives to history.

## My contribution

After being tasked with implementing an ABM with a military theme in CSS739, I combined my love of World War II (WWII) history, and my new-found knowledge of military simulation techniques. The result was my award-winning (winner of the best paper at the 16th MABs conference) <a href="https://link.springer.com/chapter/10.1007/978-3-319-46882-2_5" target="blank">To Big Wing, or Not to Big Wing, Now an Answer</a> paper. For this paper, I was lucky enough to lean on the previous work of the <a href="http://www-users.york.ac.uk/~nm15/ynt/YHWAG.html" target="blank">York Historical Warfare Analysis Group</a>.

### The Battle of Britian

<iframe width="650" height="365" src="https://www.youtube.com/embed/CkKZSvwvY3w" frameborder="0" gesture="media" allowfullscreen></iframe>

The Churchillian quote, "Never, in the field of human conflict, was so much owed by so many to so few," encapsulates perfectly the heroics of Royal Air Force (RAF) Fighter Command (FC) during the Battle of Britain. Despite the undoubted heroics, questions remain about how FC employed the "so few." In particular, the question as to whether FC should have employed the "Big Wing" tactics, as per 12 Group, or implement the smaller wings as per 11 Group, remains a source of much debate. In this paper, I create an agent-based model (ABM) simulation of the Battle of Britain, which provides valuable insight into the key components that influenced the loss rates of both sides. It provides mixed support for the tactics employed by 11 Group, as the model identified numerous variables that impacted the success or otherwise of the British.

## References
Scogings, C., & Hawick, K. (2012). An agent-based model of the Battle of Isandlwana (pp. 1–12)._IEEE_. 
<a href="https://doi.org/10.1109/WSC.2012.6465043" target="blank">https://doi.org/10.1109/WSC.2012.6465043</a>

Trautteur, G., & Virgilio, R. (2003). An agent-based computational model for the Battle of Trafalgar: a comparison between analytical and simulative methods of research (pp. 377–382). _IEEE Comput. Soc_. <a href="https://doi.org/10.1109/ENABL.2003.1231440" target="blank">https://doi.org/10.1109/ENABL.2003.1231440</a>

<!-- Start of SimpleHitCounter Code -->
<div align="center"><a href="http://www.simplehitcounter.com" target="_blank"><img src="http://simplehitcounter.com/hit.php?uid=2324964&f=16777215&b=0" border="0" height="18" width="83" alt="web counter"></a><br><a href="http://www.simplehitcounter.com" target="_blank" style="text-decoration:none;">web counter</a></div>
<!-- End of SimpleHitCounter Code -->
