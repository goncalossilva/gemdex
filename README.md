# GEMDEX

GEMDEX is a web-based ruby gem comparison and discovery tool.  
Its name is a portmanteau word of (ruby) gem and index, much alike a [rolodex](http://en.wikipedia.org/wiki/Rolodex).

Every ruby developer has been there: "what gem should I use for this? Is it still maintained? What about documentation?". GEMDEX is here to give you those answers.

For additional details, please look at our Rails Rumble 2013 [entry page](http://railsrumble.com/entries/266-gemdex).

## Main features

  - battle mode: compare two gems side-by-side and rate them across different criteria
  - index mode: search and review information about a specific gem or a given category

## Criteria

GEMDEX rates gems according to multiple metrics, which can be aggregated in three main categories:

  - **Activity**: the project public activity — e.g. frequency of commits, issues and pull requests management
  - **Social**: popularity of the project within the community — e.g. GitHub stars, project forks
  - **Etiquette**: code standards and documentation — e.g. release versioning, availability of detailed documentation
 
### How is the gem analysis performed?

GEMDEX retrieves the required information using the [GitHub API v3](http://developer.github.com/v3/), calculating a subset of 18 metrics which are weighed to generate the results,

## Relevance and motivation

As Ruby and Ruby on Rails developers, we often go looking for available ruby gems which can fix a problem or implement a given feature. After finding one or several gems, the problem easily becomes how to answer the question of using a given gem — is it still maintained, is there a better one, what is the license?

Up until now, existing alternatives are:

  - [The Ruby Toolbox](https://www.ruby-toolbox.com/) a.k.a. **a ruby gem index**
  - searching [StackOverflow](http://stackoverflow.com/) for opinions, problems and recommendations, a.k.a. **community validation**
  - checking the GitHub project page for the gem, to check on activity, issues and pull requests, and documentation, a.k.a. **gem relevance**

With GEMDEX you can browse this information in one single place, and compare it directly across different gems.
