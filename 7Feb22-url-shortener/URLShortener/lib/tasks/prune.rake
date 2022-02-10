namespace :prune do
    desc "Purge stale URLs for non-premium users"
    task prune_stale_urls: :environemnt do
        puts "Pruning stale URLs..."
        minutes = ENV['prune_minutes'].to_i || 360
        ShortenedURL.prune(minutes)
    end
end