# GEMDEX

GEMDEX is a web-based ruby gem comparison and discovery tool.  
Its name is a portmanteau word of (ruby) gem and index, much alike a [rolodex](http://en.wikipedia.org/wiki/Rolodex).

Every ruby developer has been there: “What gem should I use for this? Is it still maintained? What about documentation?”. GEMDEX is here to give you those answers.

For additional details, please look at our Rails Rumble 2013 [entry page](http://railsrumble.com/entries/266-gemdex).

## Main features

  - **Battle mode**: compare two gems side-by-side and rate them across different criteria
  - **Index mode**: search and review information about a specific gem or a given category

## Criteria

GEMDEX rates gems according to multiple metrics, which can be aggregated in three main categories:

  - **Activity**: the project public activity — e.g. frequency of commits, issues and pull requests management
  - **Social**: popularity of the project within the community — e.g. GitHub stars, project forks
  - **Etiquette**: code standards and documentation — e.g. release versioning, availability of detailed documentation

Information is retrieved using the [GitHub API v3](http://developer.github.com/v3/). An analysis is performed by calculating a subset of 18 metrics which are weighed to generate the results.

## Relevance and motivation

Finding a great gem can sometimes be an annoying and time consuming experience. Is this gem any good? It is actively maintained? What about this other one? What is the license? Is it easy to contribute back if I want to?

Up until now, finding that great gem would probably involve:

  - Checking out [The Ruby Toolbox](https://www.ruby-toolbox.com/) a.k.a. **a ruby gem index**
  - Searching on [StackOverflow](http://stackoverflow.com/) for opinions, problems and recommendations, a.k.a. **community validation**
  - Reading the [GitHub](http://github.com/) project page for the gem, to check the activity, issues and pull requests, documentation, a.k.a. **gem relevance**

With GEMDEX you can browse this information in one single place, and compare it directly across different gems.
