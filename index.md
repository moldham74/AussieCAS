# Purpose

This website is a compilation of not only my work in the field of complexity/complex adaptive systems (CASs) and agent-based modelling (ABM) but also many of the works that have served as inspiration for me along the way. I have provided numerous links to videos and readings which I hope you will find useful.

The website is updated regularly with new [articles](https://moldham74.github.io/AussieCAS/articles.html) that I find and post on either my <a href="https://www.linkedin.com/in/oldhamma" target="blank">Linkedin</a> or <a href="https://twitter.com/maoldham74" target="blank">Twitter</a> sites. You may even wish to email me at oldhamma@gmail.com.

## Introduction to the author
To make more informed investment decisions in an increasingly complex world, I have returned to university to study the emerging field of Computational Social Science (CSS). In particular I want to apply new interdisciplinary methods to gain a greater understanding of how financial markets behave and to explore the dynamics driving innovation. The details of how and why are contained on this website.

## What you will find:
* **[_About me_](https://moldham74.github.io/AussieCAS/about.html)**: This page provides more details about me, including my academic and work background. I also provide a further explanation about what I am currently studying and why.

* **_My research interests_**

  *  **[_Economics:_](https://moldham74.github.io/AussieCAS/econ.html)** o	There are rich pickings in terms of assessing the economy as a complex adaptive system (CAS). This page touches on the reasons for this. In addition, I provide an example of my work in the field.
  
  *  **[_Finance:_](https://moldham74.github.io/AussieCAS/finance.html)** There has been considerable effort, and success, in analyzing financial markets as CASs. I provide some of the background and outline my work in the area on this page.
  
  *  **[_Sports:_](https://moldham74.github.io/AussieCAS/sports.html)** As sports analytics continues its meteoric growth, the availability of massive quantities of data has enabled researchers to uncover the fact that certain sports may be CASs. I highlight some of the papers and provide an outline of my soon-to-be-released basketball agent-based model.

  *  **[_Military Applications:_](https://moldham74.github.io/AussieCAS/military.html)** ABM has made a meaningful contribution to the defense sector. Here I touch on the background and present my contribution to the field.
  
* **[_Publications:_](https://moldham74.github.io/AussieCAS/pub.html)** This page provides a link to the various works that I have had published.

* **[_Reading list:_](https://moldham74.github.io/AussieCAS/reading.html)** Along my learning journey I have managed to come across a variety of great books. In this section I highlight the books I found the most interesting. There is also a link to the various papers that I mention throughout my website.

# The background to this website
## What are complex adaptive systems, and why are they important?
A CAS can be anything from an ecological to an economic system. The key characteristics of these systems are that the agents within the system interact in a non-linear fashion with other agents and with their environment. These interactions result in the emergence of complex collective behavior; that is to say, a small number of rules applied locally are responsible for generating complex global phenomena. This is turn ensures the system is non-stationary, making it difficult to predict the behavior of the system beyond a certain temporal window. 

A key attribute of a CAS are emergent outcomes, which can be defined as larger entities, patterns, and regularities arising from the interactions of smaller or simpler entities that themselves do not exhibit such properties. Other distinguishing features of a CAS are the presence of feedback effects (both positive and negative), and the adaptations and evolution of the agents.

Here is a 10-minute video that does a great job of explaining it.

<iframe width="650" height="365" src="https://www.youtube.com/embed/vp8v2Udd_PM" frameborder="0" gesture="media" allowfullscreen></iframe>

It is the presence of these unexpected emergent outcomes that underlies the need to gain a greater understanding of CASs. Classic examples of these emergent behavior include how communities become highly segregated, despite the population not being predisposed to segregation (see Schelling (1971); how birds form large flocks; how traffic jams form and propagate; or how asset bubbles are created.

In terms of complexity science, it should be noted that it is not a theory per se but rather a movement in the sciences that studies how the interacting elements in a system create overall patterns, and how these overall patterns in turn cause the interacting elements to change or adapt.

## Why study Computational Social Science?
Computational social science (CSS) is an exciting and emerging discipline that is at the intersection of social science, math, and computer science. The intention of CSS is to utilize numerical models and data analytics to further our understanding of societies, markets, and human behavior. In contrast to traditional approaches to social science (e.g., inferential statistics, axiomatic modeling, or interviews), the computational approach presents both unique opportunities and methodological challenges. For example, how should adaptative behavior be introduced? How do we evaluate policies and outcomes when decision-makers exhibit bounded rationality? How do we avoid spurious inferences resulting from an over-analysis of data? It is by combining formalized theories and empirical research that researchers can study and further develop their understanding of social complexity via methods not available elsewhere.

Within the CSS framework various computational and modelling tools have been, and continue to be, developed to understand and/or make predictions regarding social science issues. Examples of the techniques employed are: agent-based modelling, social network analysis, machine learning, content analysis, and geographic information systems. 

I have provided the following video from the <a href="(http://www.kellogg.northwestern.edu/news-events/conference/ic2s2/2016.aspx" target="blank">2nd Annual International Conference on Computational Social Science</a>, hosted by the Kellogg School of Management, Northwestern University, to help explain what CSS is and is not. In the video, several speakers discuss the definition of CSS, with an important point being made by the first presenter, Duncan Watts, when he mentions that initially CSS revolved around simulations but it is now growing into a much larger and more diverse field.

<iframe width="650" height="365" src="https://www.youtube.com/embed/kyZkptxlSA8" frameborder="0" gesture="media" allowfullscreen></iframe>

## What are agent-based models, and why use them?
Simon (1996) makes the point that complex adaptive systems are predisposed to simulation. The rationale is that one does not need to identify the properties of all parts of a system in their entirety if the goal is to understand how the parts organize themselves to create certain macro outcomes. In turn, these outcomes are likely to arise independently of all but a few properties of the individual components. Thereby through simulation one can assess emergent outcomes from a bottom-up perspective. In trying to simulate these emergent processes researchers are required to make certain abstractions, with the intention being to create a model of a target that is simpler to study than the target itself.

<iframe width="650" height="365" src="https://www.youtube.com/embed/stziwtQBrZ0" frameborder="0" gesture="media" allowfullscreen></iframe>

One method of simulation that can achieve the objectives of bottom-up simulation is ABM. Agent-based models (ABMs) allow researchers to assess, in a silicon laboratory, the micro-level interactions that give rise to verifiable macro outcomes. This is achieved through heterogeneous agents adapting and making decisions based on their environment, including considering spatial and temporal factors and from interactions with other agents. Additionally, the agents in these models are not constrained to equilibrium conditions. Therefore, ABMs allow one to understand and predict from the bottom up.

The key benefits of ABM over other simulation techniques, as articulated by Axtell (2000), are that it may be the only way to uncover the solution structure, test the dynamics of the system, and test the sensitivity of the model’s output against its parameters and assumptions. In implementing an agent-based model the principle is to make the rules as simple as possible yet generate the emergent behavior at the system or macro level.

### References

Axtell, R. (2000). Why agents?: on the varied motivations for agent computing in the social sciences. _Center on Social and Economic Dynamics Brookings Institution._

Schelling, T. C. (1971). Dynamic models of segregation. _Journal of Mathematical Sociology, 1_(2), 143-186.

Simon, H. A. (1996). _The Sciences of the Artificial (3rd ed)._ Cambridge, Mass: MIT Press.

<!-- Start of SimpleHitCounter Code -->
<div align="center"><a href="http://www.simplehitcounter.com" target="_blank"><img src="http://simplehitcounter.com/hit.php?uid=2323738&f=16777215&b=0" border="0" height="18" width="83" alt="web counter"></a><br><a href="http://www.simplehitcounter.com" target="_blank" style="text-decoration:none;">web counter</a></div>
<!-- End of SimpleHitCounter Code -->
