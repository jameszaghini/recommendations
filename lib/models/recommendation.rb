# frozen_string_literal: true

Recommendation = Struct.new(:job_id,
                            :job_title,
                            :jobseeker_id,
                            :jobseeker_name,
                            :matching_skill_count,
                            :matching_skill_percent)
