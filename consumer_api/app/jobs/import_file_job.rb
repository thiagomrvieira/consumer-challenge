class ImportFileJob < ApplicationJob
  queue_as :file_import

  def clean_utf8(data)
    data.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
  end

  def perform(file_path)
    redis = $redis

    file_content = File.read(file_path)
    clean_content = clean_utf8(file_content)

    file_data = JSON.parse(clean_content)

    total_records = file_data.size
    processed_records = 0

    redis.set("import_progress_#{self.job_id}", 0)

    file_data.each_slice(500) do |batch|
      ImportBatchJob.perform_later(batch)
    end

    redis.set("import_progress_#{self.job_id}", total_records)
  end
end
