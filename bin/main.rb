#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/job_reccomendation_app'

require 'pathname'
ROOT = Pathname.pwd

JobReccomendationApp.run
