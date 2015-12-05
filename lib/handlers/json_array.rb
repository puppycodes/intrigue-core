module Intrigue
module Handler
  class BulkJson < Intrigue::Handler::Base

    def self.type
      "bulk_json"
    end

    def process(task_result, options)
      # Write it out
      File.open("#{$intrigue_basedir}/results/results.bulk", "w+") do |file|
        file.flock(File::LOCK_EX)
        results = JSON.parse file.read
        results << task_result.export_hash
        file.write(JSON.pretty_generate(results))
      end
    end

  end
end
end
