# how-we-work

A simulation that aims to show visually how software teams work, autonomously and as part of a larger org, and the effects of planning, legacy, knowledge sharing, and communication can affect delivery.

![Team simulation gif](https://user-images.githubusercontent.com/7750/140018243-5e4c9298-4e7c-4002-987c-699c9593b19d.gif)

![Calendar simulation gif](https://user-images.githubusercontent.com/7750/140018209-037f7aa9-5417-45b8-ac87-831966e9a60c.gif)

This project was created to create some short animations, to be included in an overall talk about how we work at TX Conference 2021 in Zurich.

Code by [Jeremy Seitz](https://somebox.com/jeremy), illustrations by [Christina Haupt](https://www.instagram.com/chauptart/?hl=en)

## The Talk

(links to be posted later)


## Examined are some scenarios, which the simulation and talk address:

- how availabilty, stability of the team, and planning affects work
- Showing how faster iterations can lead to faster learning
- Seeing how complexity in tasks (or the platform) can slow us down
- Visualize how pairing and reviews don't reduce output
- Show how external dependencies (on resources or changes) affect flow
- Show how interruptions affect progress
- Show teams that have cycles aligned, vs independent and the impact here
- Show overhead of comms and alignment
- Show how outside, unplanned work can impact progress towards goals
- Show the calendar problem visually, how time fills up in "first available" fashing, why blocking time and having shared rituals help

### A Whole Organization
- many teams in progress, in different departments, separately aligning with stakeholders; vs. full-scale planning and reduction of meetings
- the cumulative effect of legacy or changing goals on a software org, how the whole system is affected
- bottlenecks that slow down everyone (ex: approvals, under-provisioned design, waiting for research, "big" company projects that interrupt)

## **Visualizations/Examples**

### Calendars

By looking at a selection of developer's calendar weeks, we can show how little time there is to actually work. The cost of task switching and getting "into the flow" requires that we make large slots of time open for engineers.

As most meetings are "first come, first serve" we run into a prioritization problem. Important topics might have to wait because people are not available, while non-urgent matters might get scheduled earlier (or on a recurring basis) simply because they were scheduled ahead of time.

### Coordination

The lack of coordinated planning and production increments leads to many unplanned discussions and tasks, which interrupt the flow of work and reduce productivity. The solution here is to line up **production cycles** (or "PI"s) to have all prioritization and commitments set for a period of time.

If we calculate the total cost of all-hands planning, it looks expensive at first. But when we compare that to the cost of follow-ups, unplanned work, status reporting, and additional meetings, the advantage is huge for the productivity realized.

Change takes time, and practice. It requires perseverance: [https://twitter.com/ScottWlaschin/status/560495507685249024](https://twitter.com/ScottWlaschin/status/560495507685249024)

### The Real Cost of Maintenance

Code that is hard to understand or undocumented costs time, in terms of interruptions and delays. The strategy here is to identify the constraints:

- the components of the system that take the most time and comprehension away from developers, and the code that is the most difficult to change and modify (often legacy, but not only)
- the dependencies on teams or people that are most overloaded, and cause others to wait. According to the Theory of Constraints, these bottlenecks will determine the maximum output of the whole group. Work to use them efficiently and prioritize carefully.
- constant investment in documentation, standards, and automation help the overall development efforts to get faster
- CI/CD and automated tests help reduce the amount of focus lost to quality issues and incidents, leading to "re-work" and operational load
- The amount of time it takes an individual developer to spin up a dev environment, review and release code - improvements here have a big impact on the productivity of all developers

Avoid the "big rewrite", look to contain and control all parts of the platform and to share as much as possible through standards and inner open source. This ensures know-how is spread and complexity is constantly reduced. Strike the right balance between autonomous teams and build-up of silos.

## Why Culture and Rituals Matter

The transparency of the org, what a good "festival" looks like and the impact, how to move away from reporting and assigning tasks, and how autonomy and purpose drive performance. What modern Product Management techniques teach us about teamwork. How "Culture Eats Strategy for Breakfast" and how this relates to software development in a modern way (review, inner-source, standards over architecture)

## Inspirations
- Book: [The Goal](https://www.amazon.com/Goal-Process-Ongoing-Improvement/dp/0884271951) (1984)
- Book: [The Phoenix Project](https://itrevolution.com/the-phoenix-project/) (2013)
- Book: [Brick By Brick - How Lego Changed the Rules of Innovation](https://www.amazon.com/Brick-Rewrote-Innovation-Conquered-Industry/dp/0307951618) (2013)
- Book: [Team Topologies](https://teamtopologies.com/) (2019)
- Article: [Pragmatic Engineer - How Big Tech Runs Tech Projects and the Curious Absence of Scrum](https://newsletter.pragmaticengineer.com/p/project-management-in-tech?utm_source=pocket_mylist)
- The [Theory of Constraints](https://en.wikipedia.org/wiki/Theory_of_constraints)
- [Managing by Outcomes](https://www.producttalk.org/2019/10/managing-outcomes/) (product management talk)
- Book: [A Practical Approach to Large-Scale Agile Development](https://www.amazon.com/Practical-Approach-Large-Scale-Agile-Development/dp/0321821726)
- Book Synopsis: [An Elegant Puzzle: Systems of Engineering](https://medium.com/@sjonany/book-an-elegant-puzzle-systems-of-engineering-management-will-larson-f729447a43c)
- Talk: [Software Myths Busted](https://www.youtube.com/watch?v=GF_jiO73L7o)
- Talk: [If Agile is good, why are our Product so bad?](https://www.youtube.com/watch?v=2JNXx8VdbAE)
- Talk: [Why Scaling Agile Doesn't Work](https://www.youtube.com/watch?v=2zYxWEZ0gYg)



## Dev Environment - Simulations

All code is in [Processing](https://processing.org) v4 beta, with an interactive UI to adjust parameters and scenes. 
** PULL REQUESTS WELCOME **

To run the project, `git clone`, and open the file `team_simulation.pde` in the editor environment. Processing is basically Java, but using supplied patterns like graphics primitives, setup/draw loop, and helpful structures like ArrayList, 1st-class color values, Vectors, etc). The calendar simulation is separate, and is mostly visual (not much simulation going on, other than filling up work with meetings!).

TODO Ideas: 
- [x] output video files from the animations directly when needed.
- [x] track history of a teams sprint outcomes, show progress on a graph
- [ ] introduce a mini-calendar that shows how team time is taken up
- [ ] meetings and the interruption of flow, standups, plannings, retros
- [ ] pairing on code, how increased understanding and quality at a small cost to time
- [ ] show multiple teams and dependencies between them
- [ ] communication lines between people as a something that takes work
- [ ] experience and developer experience as variables that affect speed
- [x] technical debt levels and effect on speed
- [ ] extra big backlogs and cognitive load
- [x] complexity of tasks (high complexity makes things harder)
- [ ] costs in real money and totals for teams and tasks
- [ ] model a company planning ritual after 6-7 sprints
- [x] outside interference (group projects, unplanned work)
- [ ] quality issues like bugs, outages
- [ ] moving people between teams and onboarding time

