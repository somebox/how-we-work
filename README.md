# how-we-work

A simulation that aims to show visually how software teams work, and the flow of value delivered.

<img width="523" alt="Screenshot 2021-10-13 at 14 05 35" src="https://user-images.githubusercontent.com/7750/137129098-7e1c99ff-df04-42bc-acb7-46b3f5cb1c5d.png">

These are meant to be short animations, included in an overall talk about how we work.

## Examined are some scenarios:

### A single team
- how availabilty, stability of the team, and planning affects work
- Showing how faster iterations can lead to faster learning
- Seeing how complexity in tasks (or the platform) can slow us down
- Visualize how pairing and reviews don't reduce output
- Show how external dependencies (on resources or changes) affect progres
- Show how interruptions affect progress

### A single team
Looking at multiple teams
- Show teams that have cycles aligned, vs independent and the impact here
- Show overhead of comms and alignment
- Show how outside, unplanned work can impact progress towards goals
- show the calendar problem visually, how time fills up in "first available" fashing, why blocking time and having shared rituals help

### A single team
Looking at a whole org
- Show 10 teams in progress, separately aligning with stakeholders; vs. festival planning and reduction of meetings
- Show the cumulative effect of legacy or changing goals on a software org, how the whole system is affected
- Show bottlenecks that slow down everyone (ex: approvals, under-provisioned design, waiting for research, "big" company projects that interrupt)



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
