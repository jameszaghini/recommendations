# frozen_string_literal: true

Recommendation = Struct.new(:jobseeker_id, :jobseeker_name, :job_id, :job_title, :matching_skill_count,
                            :matching_skill_percent)
