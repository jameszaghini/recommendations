#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/job_recommendation_app'

require 'pathname'
ROOT = Pathname.pwd

JobRecommendationApp.run
