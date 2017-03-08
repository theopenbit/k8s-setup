#!/usr/bin/ruby
require 'yaml' 
require 'optparse'
require 'erb'
template='index.html.erb'
options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: svc2html.rb [options]"

  opts.on("-i", "--input filename",String,"input yaml file with svc info") do |i|
    options[:input] = i
  end
  opts.on("-o ", "--output filename",String,"output html file with svc info") do |o|
    options[:output] = o
  end
  opts.on("-k", "--k8s url", String,"url of kubernetes cluster") do |k|
    options[:kubernetesmaster] = k
  end
end

begin
   optparse.parse!
   mandatory = [:input, :output, :kubernetesmaster]
   missing = mandatory.select{ |param| options[param].nil? }
   raise OptionParser::MissingArgument, missing.join(', ') unless missing.empty?
rescue OptionParser::ParseError => e
   puts e
   puts optparse
   exit
end

inputfile=options[:input]
outputfile=options[:output]
kubernetesmaster=options[:kubernetesmaster]
svc= YAML.load_file(inputfile)
if svc.nil? then
    puts '#{inputfile} not found'
    exit 1
end

namespaces = Hash.new
services= Array.new
svc['items'].each do |item| 
    services = namespaces[item['metadata']['namespace']]
    if services.nil? then
        services = Array.new
        namespaces[item['metadata']['namespace']]=services
    end
    service = Hash.new
    service['name'] = item['metadata']['name']
    service['namespace'] = item['metadata']['namespace']
    service['type'] = item['spec']['type']
    if service['type'] == 'NodePort' then
        service['ports'] = Array.new
        item['spec']['ports'].each do |nodeport|            
            port = Hash.new
            port['name'] = nodeport['name']
            port['port'] = nodeport['nodePort']
            service['ports'] <<  port
        end
    end
    services << service
end
renderer = ERB.new(File.read(template))
htmlcontent = renderer.result()

File.write(outputfile, htmlcontent)



