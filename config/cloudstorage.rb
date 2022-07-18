def quickstart bucket_name:
    # Imports the Google Cloud client library
    require "google/cloud/storage"
  
    # Instantiates a client
    storage = Google::Cloud::Storage.new
  
    # The ID to give your GCS bucket
    # bucket_name = "your-unique-bucket-name"
  
    # Creates the new bucket
    bucket = storage.create_bucket bucket_name
  
    puts "Bucket #{bucket.name} was created."
  end