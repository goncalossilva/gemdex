#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

repo =  Octokit.repository 'rails/rails'
ap repo.attrs
