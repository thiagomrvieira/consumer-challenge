class ImportFileJob < ApplicationJob
  queue_as :file_import

  def perform(file_path)
    file_data = JSON.parse(File.read(file_path))

    file_data.each_slice(1000) do |batch|
      ImportBatchJob.perform_later(batch)
    end
  ensure
    File.delete(file_path) if File.exist?(file_path)
  end
end
