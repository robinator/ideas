require 'rcov/rcovtask'
require 'metric_fu'
require 'flog'

def flog_runner(threshold, dirs)
  flog = Flog.new
  flog.flog dirs
  average_threshold = threshold / 3.0
  puts "=============================================="
  puts "Flog output for #{dirs.join(", ")}:"
  puts "Method threshold: %4.1f \nAverage threshold: %4.1f" % [threshold, average_threshold]
  puts "Flog total: %17.1f" % [flog.total]
  puts "Flog method average: %8.1f" % [flog.average]
  puts ""
  bad_methods = flog.totals.select do |name,score|
    score > threshold
  end
  bad_methods.sort { |a,b| a[1] <=> b[1] }.each do |name, score|
    puts "%8.1f: %s" % [score, name]
  end
   
  puts "#{bad_methods.size} methods have a flog complexity > #{threshold}" unless bad_methods.empty?
  puts "Average flog complexity > #{average_threshold}" unless flog.average < average_threshold
  puts "=============================================="
  puts ""
end

desc 'Run all rails tests'
task :analyze => ["analyze:default"]
namespace :analyze do
  SECTIONS = {
    "units" => {:folders => "app\/models|app\/helpers|lib"},
    "functionals" => {:folders => "app\/controllers"},
    "integration" => {}
  } 

  task :default => [:test, :flog, :flay]

  desc "Run all Rails tests with rcov on units and functionals"
  task(:test) do
    SECTIONS.each do |section_name, section|
      puts "#################################################"
      puts "Running #{section_name.singularize} tests"
      puts "#################################################"
      Rake::Task["analyze:#{section_name}"].invoke
      unless section[:folders].nil?
        puts "HTML output: <file:///#{File.join([Rails.root, 'coverage', section_name, 'index.html'])}>"
      end
      puts "\n\n"
    end
  end

  SECTIONS.each do |section_name, section|
    unless section[:folders].nil?
      Rcov::RcovTask.new("#{section_name}") do |t|
        t.libs << "test"
        t.test_files = Dir["test/#{section_name.singularize}/**/*_test.rb"]
        t.rcov_opts = ["--html", "--text-report", "--exclude '^(?!(#{section[:folders]}))'"]
        t.output_dir = "coverage/#{section_name}"
      end
    end
  end

  task :integration => ["test:integration"]

  desc "Run Flog"
  task(:flog) do 
    flog_runner(30, ['app/models', 'app/helpers', 'lib']) 
    flog_runner(45, ['app/controllers'])
  end

  desc "Run Flay"
  task(:flay) do
    require 'flay'
    puts "=============================================="
    puts "Flay output: "
    threshold = 25
    flay = Flay.new({:fuzzy => false, :verbose => false, :mass => threshold})
    flay.process(*Flay.expand_dirs_to_files(['app/models', 'app/helpers', 'lib']))
    flay.report

    puts "#{flay.masses.size} chunks of code have a duplicate mass > #{threshold}" unless flay.masses.empty?
    puts "=============================================="
    puts ""
  end

end