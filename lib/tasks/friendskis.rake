namespace :friendskis do
  task :update_stats => :environment do
    User.compute_scores!
    User.compute_rankings!
  end
end
