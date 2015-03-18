worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout 15
preload_app true


before_fork do |server, worker|
  Signal.trap 'TERM' do
    # Unicorn master intercept TERM and send QUIT instead
    Process.kill 'QUIT', Process.pid
  end
  defined?(ActiveRecord) && ActiveRecord::Base.connection.disconnect!
end 


after_fork do |server, worker|
  Signal.trap 'TERM' do
    # Unicorn worker intercept TERM and do nothing.
    # Wait for master to send QUIT.
  end
  defined?(ActiveRecord) && ActiveRecord::Base.establish_connection
end
