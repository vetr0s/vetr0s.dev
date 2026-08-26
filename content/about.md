---
title: "About"
---

Hi! You made it past the home page! I really appreciate your interest. As a reward,
I give you this page, which is your opportunity to learn a *little* more about me.

## Education

I graduated from the [University of Arizona](https://www.arizona.edu/) in May
2026 with a Bachelor of Science in [Computer
Science](https://www.cs.arizona.edu/). Before Arizona, I grew up in
[Washington](https://en.wikipedia.org/wiki/Washington_(state)), where I earned
my associate's degree alongside my high school diploma through the state's
[Running Start](https://en.wikipedia.org/wiki/Running_Start)[^running-start]
program.

[^running-start]: Running Start lets Washington high schoolers take community
    college classes for joint credit, tuition-free.

Notably, this is where I took my first real-deal programming courses, which
eventually allowed me to skip CSc 110 and 120 (the basic intro courses at UofA).

### Undergraduate Teaching Assistantship

During Spring 2025 I worked as a Teaching Assistant for CSc 346: Cloud
Computing[^csc-346] at the [University of Arizona](https://www.cs.arizona.edu/).

[^csc-346]: CSc 346 covers [cloud
    computing](https://en.wikipedia.org/wiki/Cloud_computing) fundamentals:
    IaaS, PaaS, SaaS, and hands-on work with major providers.

This not only strengthened my experience working with cloud technologies and
providers, but it also taught me how to communicate better. Every week that
semester, I had the chance to host office hours for students who needed help
either understanding the content of the course or debugging issues within
their projects. During these sessions, I would help around 2-4 students in a
2-hour time window. Funnily enough, my office hours were held the day before
the weekly homework was due, so they became each student's last-ditch effort
to get a decent grade on that week's homework. That was an interesting
experience, to say the least. But I loved doing it. Most of the debugging work
amounted to fixing typos, forgetting to
[scp](https://en.wikipedia.org/wiki/Secure_copy_protocol) the most recent
local changes made to the EC2 server, or helping students set up their
development environments. So overall pretty small potatoes technically
speaking.

But each week I had to do the assignments myself, which was a joy in
and of itself since the curriculum was pretty different than when I had taken
it a year prior as a student myself. For example, our capstone project in the
course when I was a student was an Instagram clone combining AWS EC2, S3, and
Lambda (or their equivalents). And while the course outcomes stayed the same,
when I became a TA for the course my students had a bit more of a
choose-your-own-adventure-style project, where they could opt to build
something like a Minecraft server on EC2 among a multitude of options.

## HackAZ 2026

In April 2026 I spent 24 hours with three teammates building **GridWise
Energy**[^gridwise] at [Hack Arizona](https://hack.arizona.edu)[^hackaz], the
University of Arizona's flagship hackathon, on the AI Environmental
Sustainability track.

[^hackaz]: Hack Arizona, often shortened to HackAZ, is a 24-hour student-run
    hackathon held every spring at UofA.

[^gridwise]: The project lives at
    [github.com/JHGN-ORG/Gridwise-Energy](https://github.com/JHGN-ORG/Gridwise-Energy).

GridWise Energy is a personal electricity carbon footprint tracker for
Arizona residents. You log usage on your heavy appliances: HVAC, EV charger,
pool pump, dryer. The app estimates the CO2 those habits cost against the
local grid mix, tracks real-time grid carbon intensity, and nudges you to
shift heavy loads to whenever solar and Palo Verde's nuclear baseload are
carrying more of the load. We shipped it as **Griddaddy** at
[griddaddy.us](https://griddaddy.us).

The stack is React, TypeScript, and Vite on the frontend, Tailwind and
shadcn/ui for styling, Vercel serverless functions on the backend, a Neon
Postgres database, and Auth0 for auth. For the AI half of the track, we wired
in a Gemini-backed chatbot for usage insights and trained a small ridge
regression model to forecast grid carbon intensity.

I built it with [Heng-Pok](https://github.com/Heng-Pok), [John
Imanishimwe](https://github.com/JohnVianme), and
[Garret](https://github.com/gsw2019).

Please enjoy this picture of us, extremely exhausted after presenting our
project live in front of the judges and getting little sleep the night
before.

<figure>
<img src="/img/hackaz_team.webp" alt="Myself and my three GridWise Energy teammates smiling in front of the Hack Arizona 2026 judging countdown screens, with our project dashboard open on a laptop in front of us" width="1600" height="1200" loading="lazy" decoding="async" />
<figcaption>The GridWise Energy team at Hack Arizona 2026.</figcaption>
</figure>

On a more personal note, this experience was amazing, and I hope to do more
hackathons in the future. All of us were graduating seniors with similar
technical capabilities, which made working on the team an awesome experience
where I got to sharpen my communication and project management skills. I
also got the chance to contribute most of the work on setting up our
development environment for the project, something I love to do. But I'd say
the most valuable part of this experience was getting to just prototype,
iterate, and ship a product in a limited amount of time with a small team.
This brought me back to high school more than I expected. "Why high school?"
you ask. Well, keep reading!

## High School Robotics

### Egypt Expedition

For 4 years I was part of [ORF 4450](https://www.orf4450.org/home), an [FRC
robotics](https://www.firstinspires.org/programs/frc/)[^frc] team. I joined as a
freshman when the roster was small. 4 of us became the dedicated core that
season, and by the time I graduated the team had grown to nearly 50 members. In
my third year, one of our mentors connected us with a mother in
[Egypt](https://en.wikipedia.org/wiki/Egypt) whose son attended a STEM school in
[Cairo](https://en.wikipedia.org/wiki/Cairo) doing [Lego-based
robotics](https://en.wikipedia.org/wiki/Lego_Mindstorms), and we set out to
raise the funds to bring metal-based robotics there. Over the next 10 months we
raised more than $60,000 through local community outreach, and in the summer
before my senior year we took 17 students to Cairo with several
[FTC](https://www.firstinspires.org/programs/ftc/) kits, plus a custom
curriculum and culminating game I co-designed as one of the team's most senior
members. The following season, the team also made it to the FRC World
Championships in [Houston](https://en.wikipedia.org/wiki/Houston) to compete for
the [Impact
Award](https://www.firstinspires.org/resources/library/frc/fia-resources).

[^frc]: FRC is the FIRST Robotics Competition, the high-school-level league
    where teams build 120-pound robots in 6 weeks.

<figure>
<img src="/img/cairo_kids.webp" alt="Myself and the teams co-captain at the Cairo STEM school working on FTC robotics kits with our group" width="1600" height="1200" loading="lazy" decoding="async" />
<figcaption>Myself and the teams co-captain at the Cairo STEM school working on
FTC robotics kits with our group.</figcaption>
</figure>

### Other Experiences

During the last 2 years I spent on the team I served as Safety Captain, which
put me in charge of all shop, robot, and event safety. In my final year I also
led the robot build team into the FRC World Championship.

<figure>
<img src="/img/huston_pit.webp" alt="Our team's pit at the FRC World Championships in Houston" width="1600" height="1200" loading="lazy" decoding="async" />
<figcaption>Our pit at the FRC World Championships.</figcaption>
</figure>

My experience in FRC shaped me as a person, engineer, problem solver, teammate,
and leader. I knew I wanted to pursue a Computer Science degree before joining;
after leaving high school, I knew more than ever that I wanted a career as
technical and challenging as FRC had been.

## Etymology

**vetr0s** (/ˈvɛt.ri/) comes from the
[Italian](https://en.wikipedia.org/wiki/Italian_language)
[*vetri*](https://en.wiktionary.org/wiki/vetri), plural of *vetro*, meaning
"glass" or "windowpane." The `0` is [leet](https://en.wikipedia.org/wiki/Leet),
because hackers have cool nicknames with numbers in them. The plural reflects my
appreciation for [open-source
software](https://en.wikipedia.org/wiki/Open-source_software), which is why I
created this site: to offer a few separate views into my work.
