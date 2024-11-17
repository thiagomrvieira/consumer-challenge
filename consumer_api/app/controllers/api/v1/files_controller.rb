class Api::V1::FilesController < ApplicationController
	def upload
		file = params[:file]
		return render json: { error: 'No file provided' }, status: :bad_request unless file

		if file.blank? || File.extname(file.original_filename) != '.json'
      return render json: { error: 'Invalid file format. Only JSON files are allowed.' }, status: :unprocessable_entity
    end

		file_path = Rails.root.join('tmp', file.original_filename)
    File.open(file_path, 'wb') { |f| f.write(file.read) }

    ImportFileJob.perform_later(file_path.to_s)

    render json: { message: 'File uploaded and import started.' }, status: :accepted
	end
end
